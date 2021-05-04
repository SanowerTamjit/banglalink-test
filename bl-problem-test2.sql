
set @domain := null;
set @startTime := null;
set @endTime := null;
set @et_ := null;
set @callID := 0;
set @TotalVolume := 0;
set @TotalTime := 0;

select final.msisdn,
       final.domain,
       final.CALL_ID,
       TotalDurationMin / 60          as DurationSec,
       final.FDR_Count,
       final.BitRate,
       IF(final.BitRate > 200, 1, 0)  as isVideo,
       IF(final.BitRate <= 200, 1, 0) as isAudio
from (
         select calData.msisdn,
                calData.domain,
                calData.CALL_ID,
                @TotalVolume := (calData.TotalDLVol + calData.TotalULVol) * 0.001   as TotalVolume,
                @TotalTime := (TIMESTAMPDIFF(MINUTE, calData.MinST, calData.MaxET)) as TotalDurationMin,
                calData.FDR_Count,
                @TotalVolume / @TotalTime                               as BitRate

         from (
                  select td.msisdn,
                         td.domain,
                         td.CALL_ID,
                         SUM(td.dlvolume)       as TotalDLVol,
                         SUM(td.ulvolume)       as TotalULVol,
                         MIN(td.prev_startTime) as MinST,
                         MAX(td.prev_endTime)   as MaxET,
                         COUNT(*)               as FDR_Count
                  from (
                           SELECT t1.*,

                                  @et_ := IF(DATE_SUB(t1.endtime, INTERVAL 10 MINUTE) < t1.starttime, t1.endtime,
                                             DATE_SUB(t1.endtime, INTERVAL 10 MINUTE)) as ET_,
                                  IF((@et_ between @startTime and @endTime) and t1.domain = @domain, @callID := @callID,
                                     @callID := @callID + 1)                           as CALL_ID,
                                  case
                                      when ISNULL(@startTime) then @startTime := t1.starttime
                                      when t1.starttime < @startTime then @startTime := t1.starttime
                                      when t1.domain != @domain then @startTime := t1.starttime
                                      else @startTime := @startTime
                                      END                                              as prev_startTime,
                                  case
                                      when ISNULL(@endTime) then @endTime := t1.endtime
                                      when t1.endtime > @endTime then @endTime := t1.endtime
                                      when t1.domain != @domain then @endTime := t1.endtime
                                      else @endTime := @endTime
                                      END                                              as prev_endTime,
                                  case
                                      when ISNULL(@domain) then @domain := t1.domain
                                      when t1.domain != @domain then @domain := t1.domain
                                      else @domain := @domain
                                      END                                              as prev_domain

                           from ipdr t1
                           order by t1.starttime ASC
                       ) td
                  GROUP BY td.msisdn, td.domain, td.CALL_ID
              ) calData
     ) final
where final.BitRate >= 10
from datetime import datetime as dt

dateFormat = '%a %d %b %Y %H:%M:%S %z'
result = []
print("Please enter the no of case you want to test: ")
n = int(input())
for i in range(n):
    try:
        t1 = dt.strptime(input(), dateFormat)
        t2 = dt.strptime(input(), dateFormat)
        if t1.year <= 3000 and t2.year <= 3000:
            result.append(abs(int((t1 - t2).total_seconds())))
        else:
            result.append("Constraints: Year")
    except ValueError as e:
        result.append("Constraints: DateFormat")
    # print(abs(int((t1-t2).total_seconds())))

print(result)

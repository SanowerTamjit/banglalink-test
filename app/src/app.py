from flask import Flask, request, jsonify
from datetime import datetime as dt
import socket

bl = Flask(__name__)

@bl.route("/", methods=["POST"])
def helloBL():
    reqInput = request.get_data().decode('utf-8').strip()
    response = getDateDiff(reqInput);
    dockerNodeId = socket.gethostname()
    return jsonify(id=dockerNodeId, result=response)


def getDateDiff(reqInput):
    dateFormat = '%a %d %b %Y %H:%M:%S %z'
    result = []

    reqInput = reqInput.split('\n')
    n = 0
    try:
        n = int(reqInput[0])
    except ValueError as e:
        result.append("Constraints: InputError")

    for i in range(1, (n*2)+1):
        if i % 2 != 0:
            continue

        try:
            t1 = dt.strptime(reqInput[i-1], dateFormat)
            t2 = dt.strptime(reqInput[i], dateFormat)
            print(t1)
            print(t2)
            if t1.year <= 3000 and t2.year <= 3000:
                result.append(abs(int((t1 - t2).total_seconds())))
            else:
                result.append("Constraints: Year")
        except ValueError as e:
            result.append("Constraints: DateFormat")
        except IndexError as e:
            result.append("Constraints: InputError")
        # print(abs(int((t1-t2).total_seconds())))
    return result

if __name__ == "__main__":
    bl.run(host='0.0.0.0')

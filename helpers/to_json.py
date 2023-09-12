import json
from datetime import datetime

def convert_matrix_to_json(header, matrix):
    data = []
    for row in matrix:
        row_dict = {}
        for i in range(len(header)):
            row_dict[header[i]] = row[i]
        data.append(row_dict)
    return json.dumps(data)

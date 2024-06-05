from flask import request, Response, json, Blueprint
from werkzeug.exceptions import HTTPException

from src.service.test_service import get_helloworld_service
test = Blueprint("test", __name__)

@test.route('/hello-world', methods = ["GET"])
def hello_world():
    helloWorldData = get_helloworld_service()
    return Response(
        response=json.dumps({'status': "success", "data": helloWorldData}),
        status=200,
        mimetype='application/json'
    )

@test.errorhandler(HTTPException)
def handle_error(error: HTTPException):
    """ Handle BluePrint JSON Error Response """
    response = {
        'error': error.__class__.__name__,
        'message': error.description,
    }
    return response, error.code
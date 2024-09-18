import 'dart:io';

import 'package:vania/vania.dart';
import 'package:hello_world/app/http/controllers/home_controller.dart';
import 'package:hello_world/app/http/middleware/authenticate.dart';
import 'package:hello_world/app/http/middleware/home_middleware.dart';
import 'package:hello_world/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.get("/home", homeController.index);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get(
            'wrong-request',
            () => Response.json(
                {'message': 'Bad Request'}, HttpStatus.badRequest))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}

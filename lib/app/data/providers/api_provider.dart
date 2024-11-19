import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook_clone/app/data/models/comment.model.dart';
import 'package:facebook_clone/app/data/models/post.model.dart';
import 'package:facebook_clone/app/data/models/user.model.dart';
import 'package:get_storage/get_storage.dart';

import '../models/login.model.dart';

class ApiProvider {
  final dio = Dio(); // used to make Http requests to the server
  final box =
      GetStorage(); // used to store and retrieve data locally such as the token and user data
  final baseUrl = 'http://192.168.18.12:8000/api';
  //Register user
  Future<bool> register({
    required String name, // required for name validation can not be null
    required String email, // required for email validation can not be null
    required String
        password, // required for password validation can not be null
    File? image, // image to be uploaded to the server can be optional
  }) async {
    try {
      var formData = FormData.fromMap(
        {
          'name': name,
          'email': email,
          'password': password,
          'image': image != null
              ? await MultipartFile.fromFile(image.path,
                  filename: image.path.split('/').last)
              : null
        },
      );
      final response = await dio.post(
          '$baseUrl/register', // set the url for the request
          data: formData, // set the data for the request
          options: Options(
              // set the headers for the request
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Email already exists");
      } else {
        throw Exception("Register Succssful");
      }
    } catch (e) {
      rethrow; // rethrow the error to be handled in the UI
    }
  }

  //Login user
  Future<LoginResModel> login(
      {required String email, required String password}) async {
    try {
      var formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await dio.post(
          // send a POST request to the server
          '$baseUrl/login', // set the url for the request
          data: formData, // set the data for the request
          options: Options(
              // set the headers for the request
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      // check status code
      print(response.statusCode);
      if (response.statusCode == 200) {
        return LoginResModel.fromJson(response
            .data); // return the response data as a LoginResModel when login is successful
      } else if (response.statusCode == 400) {
        throw Exception("Invalid email or password");
      } else {
        throw Exception("Failed to login user");
      }
    } catch (e) {
      rethrow;
    }
  }

  //logout user
  Future<bool> logout() async {
    try {
      final response = await dio.post('$baseUrl/logout',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to logout user");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get profile
  Future<UserResModel> getCurrentUserLoggedIn() async {
    try {
      final response = await dio.get('$baseUrl/me',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return UserResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to get user data");
      }
    } catch (e) {
      rethrow;
    }
  }

  //Create post method
  Future<PostResModel> getPosts() async {
    try {
      final response = await dio.get('$baseUrl/posts',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return PostResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to get user data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Create Post method
  Future<bool> createPost(
      {required String caption, required File photo}) async {
    try {
      var formData = FormData.fromMap({
        'caption': caption,
        'image': await MultipartFile.fromFile(photo.path,
            filename: photo.path.split('/').last)
      });
      final response = await dio.post('$baseUrl/posts',
          data: formData,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to create post");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Delete Post method
  Future<bool> deletePost({required String postId}) async {
    try {
      final response = await dio.delete('$baseUrl/posts/$postId',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to delete post");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Update Post method
  Future<bool> updatePost(
      {required String caption,
      required File photo,
      required String postId}) async {
    try {
      var formData = FormData.fromMap({
        'caption': caption,
        'image': await MultipartFile.fromFile(photo.path,
            filename: photo.path.split('/').last)
      });
      final response = await dio.post('$baseUrl/posts/$postId',
          data: formData,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to update post");
      }
    } catch (e) {
      rethrow;
    }
  }

  // like dislike post
  Future<bool> likeDislike({required String postId}) async {
    try {
      final response = await dio.post('$baseUrl/likes-Dislikes/$postId',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to like or dislike post");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentResModel> getComments({required String id, required String posts}) async {
    try {
      final response = await dio.get(
        '$baseUrl/$posts/$id/comments',
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${box.read('token')}",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      // Printing the raw response data
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Convert the response data to CommentResModel
        return CommentResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to get comments data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Add Comment method
  Future<bool> addComment(
      {required String postId, required String text}) async {
    try {
      final response = await dio.post('$baseUrl/comments',
          data: {'post_id': postId, 'text': text},
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        // Create comment successfully

        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to add comment");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Delete Comment method
  Future<bool> deleteComment({required String commentId}) async {
    try {
      final response = await dio.delete('$baseUrl/comments/$commentId',
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to delete comment");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> postStory(
      {required String text, required String? imagePath}) async {
    FormData formData = FormData.fromMap({
      'text': text,
      if (imagePath != null)
        'image': await MultipartFile.fromFile(imagePath, filename: 'story.jpg'),
    });

    try {
      final response = await dio.post('$baseUrl/stories',
          data: formData,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to post story");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Edit Comment method
  Future<bool> editComment(
      {required String commentId, required String text}) async {
    try {
      final response = await dio.put('$baseUrl/comments/$commentId',
          data: {'text': text},
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to edit comment");
      }
    } catch (e) {
      rethrow;
    }
  }
  //post story
  Future<bool> appstory({required String text, required File image}) async {
    try {
      var formData = FormData.fromMap({
        'text': text,
        'images': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last)
      });
      final response = await dio.post('$baseUrl/stories',
          data: formData,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer ${box.read('token')}"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("create story successfully");
      }
    } catch (e) {
      rethrow;
    }
  }
}

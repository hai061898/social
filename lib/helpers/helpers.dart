import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/bloc/user/user_bloc.dart';
import 'package:social/ui/widgets/widgets.dart';

part 'secure_storage.dart';
part 'debouncer.dart';
part 'route.dart';
part 'validate_form.dart';
part 'app_permission_img.dart';
part 'animated_toggle.dart';
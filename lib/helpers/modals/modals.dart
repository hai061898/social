import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/models/response_post.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/themes/colors.dart';
import 'package:social/ui/widgets/widgets.dart';

part 'modal_loading.dart';
part 'error_snack_mess.dart';
part 'modal_success.dart';
part 'modal_loading_short.dart';
part 'modal_warning.dart';
part 'modal_privacy_post.dart';
part 'modal_show_post.dart';
part 'modal_reel.dart';
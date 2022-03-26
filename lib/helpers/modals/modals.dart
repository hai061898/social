import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/bloc/user/user_bloc.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_post.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/screens/profile/setting_profile.dart';
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
part 'modal_privacy_profile.dart';
part 'modal_options_another_user.dart';
part 'modal_select_picture.dart';
part 'modal_profile_setting.dart';
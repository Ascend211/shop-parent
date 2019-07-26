package com.fh.shop.controller.user;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.biz.user.IUserService;
import com.fh.shop.common.IgnoreCheck;
import com.fh.shop.common.ResponseEnum;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.po.user.User;
import com.fh.shop.util.*;
import com.google.gson.JsonObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource(name="userService")
    private IUserService userService;

    @RequestMapping("/login")
    @ResponseBody
    @IgnoreCheck
    public ServerResponse login(User user, HttpServletRequest request, HttpServletResponse response) {
        // 判断用户名和密码不为空
        String userName = user.getUserName();
        String userPwd = user.getUserPwd();
        String userCode = user.getImageCode();
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(userPwd) || StringUtils.isEmpty(userCode)) {
            return ServerResponse.error(ResponseEnum.USERNAME_USERPWD_IS_EMPTY);
        }
        // 先判断验证码，减少和数据库的交互次数
        //String sessionCode = (String) request.getSession().getAttribute("code");
        String sessionId = DistributedSessionUtil.getSessionId(request, response, SystemConstant.COOKIE_NAME, SystemConstant.DOMAIN);
        String sessionCode = RedisUtil.get(KeyUtil.buildCodeKey(sessionId));
        if (!userCode.equals(sessionCode)) {
            return ServerResponse.error(ResponseEnum.CODE_IS_ERROR);

        }
        // 用户名是否正确
        User userDb = userService.findUserByUserName(userName);
        if (userDb == null) {
            return ServerResponse.error(ResponseEnum.USERNAME_IS_ERROR);
        }
        // 验证密码
        String salt = userDb.getSalt();
        if (!Md5Util.md5(userPwd+salt).equals(userDb.getUserPwd())) {
            return ServerResponse.error(ResponseEnum.USERPWD_IS_ERROR);
        }
        // 成功登录
        // 更新登录时间为当前时间
        userService.updateLoginTime(new Date(), userDb.getId());
//        request.getSession().setAttribute(SystemConstant.CURR_USER, userDb);
        // 转为json格式的字符串
        String userJson = JSONObject.toJSONString(userDb);
        RedisUtil.setEx(KeyUtil.buildUserKey(sessionId), userJson, SystemConstant.USER_EXPIRE);
        System.out.println("登录");
        return ServerResponse.success();
    }

    @RequestMapping("/toAdd")
    public String toAdd() {
        return "/user/add";
    }

    @RequestMapping("/add")
    @ResponseBody
    public ServerResponse addUser(User user) {
        userService.addUser(user);
        return ServerResponse.success();
    }

    @RequestMapping("/logout")
    @ResponseBody
    public ServerResponse logout(HttpServletRequest request, HttpServletResponse response) {
        // 清除session中的数据
        request.getSession().invalidate();
        // 清除redis中的数据
        String sessionId = DistributedSessionUtil.getSessionId(request, response, SystemConstant.COOKIE_NAME, SystemConstant.DOMAIN);
        RedisUtil.del(KeyUtil.buildUserKey(sessionId));
        // 删除cookie
        CookieUtil.deleteCookie(SystemConstant.COOKIE_NAME, SystemConstant.DOMAIN, response);
        return ServerResponse.success();
    }

    @RequestMapping("/checkUserName")
    @ResponseBody
    public ServerResponse checkUserName(String userName) {
        User userDB = userService.findUserByUserName(userName);
        if (userDB != null) {
            // 用户存在
            return ServerResponse.error(ResponseEnum.USERNAME_IS_EXIST);
        }
        return ServerResponse.success();
    }
}

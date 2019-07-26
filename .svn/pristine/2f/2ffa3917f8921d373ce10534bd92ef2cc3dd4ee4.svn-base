package com.fh.shop.biz.user;

import com.fh.shop.mapper.user.IUserMapper;
import com.fh.shop.po.user.User;
import com.fh.shop.util.Md5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.UUID;

@Service("userService")
public class IUserServiceImpl implements IUserService {
    @Autowired
    private IUserMapper userMapper;

    @Override
    public User findUserByUserName(String userName) {
        User user = userMapper.findUserByUserName(userName);
        return user;
    }

    @Override
    public void addUser(User user) {
        // 生成salt
        String salt = UUID.randomUUID().toString();
        user.setSalt(salt);
        // 给明文密码进行两次加密并结合salt
        user.setUserPwd(Md5Util.md5(Md5Util.md5(user.getUserPwd())+salt));
        userMapper.addUser(user);

    }

    @Override
    public void updateLoginTime(Date date, Integer userId) {
        userMapper.updateLoginTime(date, userId);
    }


}

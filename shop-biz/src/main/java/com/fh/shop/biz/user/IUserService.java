package com.fh.shop.biz.user;

import com.fh.shop.po.user.User;

import java.util.Date;

public interface IUserService {

    public User findUserByUserName(String userName);

    public void addUser(User user);

    void updateLoginTime(Date date, Integer userId);
}

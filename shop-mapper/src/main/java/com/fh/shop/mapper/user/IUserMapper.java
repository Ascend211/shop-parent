package com.fh.shop.mapper.user;

import com.fh.shop.po.user.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface IUserMapper {

    public User findUserByUserName(String userName);

    void addUser(User user);

    void updateLoginTime(@Param("date") Date date, @Param("id") Integer userId);
}

package com.pawsofhope.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://kodama.proxy.rlwy.net:40540/railway" +
                    "?useSSL=false&allowPublicKeyRetrieval=true";
            String user = "root";
            String password = "uljndBGVIFlWTQyalKkRfuoEnUTnVvOl";

            return DriverManager.getConnection(url, user, password);

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }
}
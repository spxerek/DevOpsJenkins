<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Session Management using Cookies</title>
</head>
<body>
    <h2>Session Management using Cookies</h2>
    <%
        String username = request.getParameter("usernm");
        Cookie[] cookies = request.getCookies();
        int visitCount = 0;
        String storedUsername = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("visitCount")) {
                    visitCount = Integer.parseInt(cookie.getValue());
                }
                if (cookie.getName().equals("username")) {
                    storedUsername = cookie.getValue();
                }
            }
        }

        // Reset visit count if a new username is provided
        if (username != null && (storedUsername == null || !storedUsername.equals(username))) {
            visitCount = 0;
        }

        visitCount++; // Increment visit count
        Cookie visitCookie = new Cookie("visitCount", String.valueOf(visitCount));
        visitCookie.setMaxAge(60 * 60 * 24);
        response.addCookie(visitCookie);

        if (username != null) {
            Cookie userCookie = new Cookie("username", username);
            userCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(userCookie);
        }
    %>
    <p>Hello <%= username != null ? username : (storedUsername != null ? storedUsername : "Guest") %>, 
       You have hit the page <%= visitCount %> time(s)</p>
    <a href="CookiesDemo.jsp?usernm=<%= username != null ? username : storedUsername %>">Hit Again</a>
</body>
</html>

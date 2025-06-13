<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Destroy the session
    session.invalidate();

    // Redirect to login page with a logout success message
    response.sendRedirect("index.jsp?logout=success");
%>

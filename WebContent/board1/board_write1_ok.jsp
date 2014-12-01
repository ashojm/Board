<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.SQLException" %>

<%@ page import = "javax.naming.Context" %>
<%@ page import = "javax.naming.InitialContext" %>
<%@ page import = "javax.naming.NamingException" %>
<%@ page import = "javax.sql.DataSource" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	
	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String mail	= request.getParameter("mail");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	
	//사용자 IP 가져 오기..
	String wip = request.getRemoteAddr();
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	int flag = 1;
	
	try{
		Context initctx = new InitialContext();
		Context envCtx = (Context)initctx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		conn = dataSource.getConnection();
		
		String sql = "insert into board1 values (board_seq.nextval, ?,?,?,?,?,0,?,sysdate)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,subject);
		pstmt.setString(2,writer);
		pstmt.setString(3,mail);
		pstmt.setString(4,password);
		pstmt.setString(5,content);
		pstmt.setString(6,wip);
		
		//executeUpdate()은 영향받은 행수
		if(pstmt.executeUpdate() == 1){
			flag = 0;
		}
	}catch(NamingException e){
		System.out.println("Namming error :" + e.getMessage());
	}catch(SQLException e){
		System.out.println("SQL error :" + e.getMessage());
	}
	
	finally{
		 if(pstmt!=null)pstmt.close();
         if(conn!=null) conn.close();
	}
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('글쓰기에 성공했습니다.');");
		out.println("location.href='./board_list1.jsp';");
	}else{
				
		out.println("alert('글쓰기에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>
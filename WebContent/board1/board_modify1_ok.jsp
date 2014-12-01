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
	
	String seq = request.getParameter("seq");
	
	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String mail = request.getParameter("mail");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	//정상은 flag = 0 비밀번호 에러는 1 프로그램 에러는 2
	
	int flag = 2;
	
	try{
		Context initctx = new InitialContext();
		Context envCtx = (Context)initctx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		conn = dataSource.getConnection();
		
		String sql = "update board1 set subject = ?,writer = ?,mail = ?,content =? where seq=? and password=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,subject);
		pstmt.setString(2,writer);
		pstmt.setString(3,mail);
		pstmt.setString(4,content);
		pstmt.setString(5,seq);
		pstmt.setString(6,password);
		
		int result = pstmt.executeUpdate();
		
		//executeUpdate()은 영향받은 행수
		if(result == 0){
			flag = 1;
		}else if(result ==1){
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
		out.println("alert('글 수정에 성공했습니다.');");
		out.println("location.href='./board_list1.jsp';");
	}else if(flag ==1){

		out.println("alert('비밀번호가 잘못되었습니다.');");
		out.println("history.back();");
	}
	
	else{
				
		out.println("alert('글쓰기에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>
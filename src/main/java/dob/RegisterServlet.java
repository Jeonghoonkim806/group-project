package dob;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberID = request.getParameter("memberID");
        String memberPW = request.getParameter("memberPW");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");

        HttpSession session = request.getSession();
//        session.invalidate();
        try (Connection conn = DBManager.getDBConnection()) {
            String checkSql = "SELECT COUNT(*) FROM members WHERE memberID = ?";
            PreparedStatement pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, memberID);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                response.sendRedirect("register.jsp?error=1");
            } else {
                String sql = "INSERT INTO members (memberID, memberPW, name, gender, email) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, memberID);
                pstmt.setString(2, memberPW);
                pstmt.setString(3, name);
                pstmt.setString(4, gender);
                pstmt.setString(5, email);
                pstmt.executeUpdate();

                session.setAttribute("memberID", memberID);

                /*
                String redirectURL = (String) session.getAttribute("redirectURL");
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    session.removeAttribute("redirectURL");
                    response.sendRedirect(redirectURL);
                } else {
                    response.sendRedirect("default.jsp");
                }
                */
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=2");
        }
    }
}
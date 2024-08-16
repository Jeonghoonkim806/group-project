package dob;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        String redirectURL = "main.jsp"; // 기본 리디렉션 페이지

        if (session != null) {
            // 세션에서 URL을 가져옵니다
            redirectURL = (String) session.getAttribute("redirectURL");

            // 로그에 리디렉션 URL 출력
            System.out.println("Redirect URL from session: " + redirectURL);

            // 세션을 무효화하여 로그아웃 처리
            session.invalidate();
        }

        // 리디렉션할 URL이 존재하고, 로그아웃 JSP가 아닌 경우 리디렉션
        if (redirectURL != null && !redirectURL.isEmpty() && !redirectURL.contains("logout.jsp")) {
            System.out.println("Redirecting to URL: " + redirectURL);
            response.sendRedirect(redirectURL);
        } else {
            System.out.println("Redirecting to default page");
            response.sendRedirect("main.jsp");
        }
    }
}
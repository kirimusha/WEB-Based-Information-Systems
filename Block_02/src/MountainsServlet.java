import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/mountains")
public class MountainsServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response) throws IOException {

    response.setContentType("text/html;charset=UTF-8");

    String country = request.getParameter("country");
    if (country == null) {
        country = "";
    }

    try {
        Class.forName("org.postgresql.Driver");

        try (Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/mountain_trekking",
                "kirimusha",
                "Katalan11251442$"
        );
             PreparedStatement st = con.prepareStatement(
                "SELECT mname, mheight, mcountry FROM mountains WHERE mcountry ILIKE ?"
        )) {

            st.setString(1, "%" + country + "%");

            try (ResultSet rs = st.executeQuery()) {
                var out = response.getWriter();

                out.println("<html><body><h1>Mountains</h1>");
                out.println("<table border='1'>");
                out.println("<tr><th>Name</th><th>Height</th><th>Country</th></tr>");

                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("mname")
                            + "</td><td>" + rs.getInt("mheight")
                            + "</td><td>" + rs.getString("mcountry")
                            + "</td></tr>");
                }

                out.println("</table></body></html>");
            }
        }

    } catch (ClassNotFoundException | SQLException e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().println("Database error: " + e.getMessage());
    }
}


}

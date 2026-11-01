import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/trips")
public class TripsServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response) throws IOException {

    response.setContentType("text/html;charset=UTF-8");

    int minDuration = 0;

    try {
        String value = request.getParameter("minDuration");

        if (value != null && !value.isEmpty()) {
            minDuration = Integer.parseInt(value);
        }
    } catch (NumberFormatException e) {
        response.getWriter().println("Invalid duration");
        return;
    }

    try {
        Class.forName("org.postgresql.Driver");

        try (Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/mountain_trekking",
                "kirimusha",
                "Katalan11251442$"
        );
             PreparedStatement st = con.prepareStatement(
                "SELECT t.ttripdate, t.tduration, t.torganizername, m.mname "
                + "FROM trips t JOIN mountains m ON t.\"M#\" = m.\"M#\" "
                + "WHERE t.tduration >= ?"
        )) {

            st.setInt(1, minDuration);

            try (ResultSet rs = st.executeQuery()) {
                var out = response.getWriter();

                out.println("<html><body><h1>Trips</h1>");
                out.println("<table border='1'>");
                out.println("<tr><th>Date</th><th>Duration</th>"
                        + "<th>Organizer</th><th>Mountain</th></tr>");

                while (rs.next()) {
                    out.println("<tr><td>" + rs.getDate("ttripdate")
                            + "</td><td>" + rs.getInt("tduration")
                            + "</td><td>" + rs.getString("torganizername")
                            + "</td><td>" + rs.getString("mname")
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

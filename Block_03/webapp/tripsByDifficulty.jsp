<%@ page contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<%
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/mountain_trekking",
        "kirimusha",
        "Katalan11251442$"
    );

    PreparedStatement st = con.prepareStatement(
        "SELECT t.\"T#\", m.mname, m.mcountry, m.mdifficulty, " +
        "t.ttripdate, t.tduration, t.torganizername " +
        "FROM trips t JOIN mountains m ON t.\"M#\" = m.\"M#\" " +
        "WHERE m.mdifficulty = ?"
    );
    st.setString(1, request.getParameter("difficulty"));

    ResultSet rs = st.executeQuery();

    String separator = "";
    out.print("[");

    while (rs.next()) {
        out.print(separator);
        out.print("{\"tripId\":" + rs.getInt("T#")
            + ",\"mountain\":\"" + rs.getString("mname")
            + "\",\"country\":\"" + rs.getString("mcountry")
            + "\",\"difficulty\":\"" + rs.getString("mdifficulty")
            + "\",\"date\":\"" + rs.getDate("ttripdate")
            + "\",\"duration\":" + rs.getInt("tduration")
            + ",\"organizer\":\"" + rs.getString("torganizername") + "\"}");
        separator = ",";
    }

    out.print("]");

    rs.close();
    st.close();
    con.close();
%>
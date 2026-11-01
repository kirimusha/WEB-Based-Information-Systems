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
        "SELECT t.ttripdate, t.tduration, t.torganizername, m.mname " +
        "FROM trips t JOIN mountains m ON t.\"M#\" = m.\"M#\" " +
        "WHERE t.tduration >= ?"
    );
    st.setInt(1, Integer.parseInt(request.getParameter("minDuration")));

    ResultSet rs = st.executeQuery();

    String separator = "";
    out.print("[");

    while (rs.next()) {
        out.print(separator);
        out.print("{\"date\":\"" + rs.getDate("ttripdate")
            + "\",\"duration\":" + rs.getInt("tduration")
            + ",\"organizer\":\"" + rs.getString("torganizername")
            + "\",\"mountain\":\"" + rs.getString("mname") + "\"}");
        separator = ",";
    }

    out.print("]");

    rs.close();
    st.close();
    con.close();
%>
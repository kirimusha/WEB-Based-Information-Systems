import java.sql.*
import groovy.json.JsonOutput

response.setContentType('application/json; charset=UTF-8')
Class.forName('org.postgresql.Driver')
def con = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/mountain_trekking",
    "kirimusha",
    "Katalan11251442\$"
)
def st = con.prepareStatement('SELECT t.ttripdate, t.tduration, t.torganizername, m.mname FROM trips t JOIN mountains m ON t."M#" = m."M#" WHERE t.tduration >= ?')
st.setInt(1, Integer.parseInt(request.getParameter('minDuration')))
def rs = st.executeQuery()
def rows = []
while (rs.next()) {
    rows.add([date: rs.getDate('ttripdate').toString(), duration: rs.getInt('tduration'), organizer: rs.getString('torganizername'), mountain: rs.getString('mname')])
}
rs.close()
st.close()
con.close()
out.print(JsonOutput.toJson(rows))

import java.sql.*
import groovy.json.JsonOutput

response.setContentType('application/json; charset=UTF-8')
Class.forName('org.postgresql.Driver')
def con = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/mountain_trekking",
    "kirimusha",
    "Katalan11251442\$"
)
def st = con.prepareStatement('SELECT t."T#", m.mname, m.mcountry, m.mdifficulty, t.ttripdate, t.tduration, t.torganizername FROM trips t JOIN mountains m ON t."M#" = m."M#" WHERE m.mdifficulty = ?')
st.setString(1, request.getParameter('difficulty'))
def rs = st.executeQuery()
def rows = []
while (rs.next()) {
    rows.add([tripId: rs.getInt('T#'), mountain: rs.getString('mname'), country: rs.getString('mcountry'), difficulty: rs.getString('mdifficulty'), date: rs.getDate('ttripdate').toString(), duration: rs.getInt('tduration'), organizer: rs.getString('torganizername')])
}
rs.close()
st.close()
con.close()
out.print(JsonOutput.toJson(rows))

<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Programadores</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

String idEditar = request.getParameter("id_programador");
String nombreEditar = request.getParameter("nombre");
String lenguajeDEditar = request.getParameter("lenguajeD");
String lenguajeCEditar = request.getParameter("lenguajeC");
String estudianteEditar = request.getParameter("estudiante");

// Insertar nuevo
if (request.getParameter("Guardar") != null) {
    String nombre = request.getParameter("nombre");
    String lenguajeD = request.getParameter("lenguajeD");
    String lenguajeC = request.getParameter("lenguajeC");
    int estudiante = request.getParameter("estudiante") != null ? 1 : 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/programadores", "root", "");
        st = con.createStatement();
        String sql = "INSERT INTO tblprogramadores (nombre, lenguajeD, lenguajeC, estudiante) VALUES ('" + nombre + "', '" + lenguajeD + "', '" + lenguajeC + "', " + estudiante + ")";
        st.executeUpdate(sql);
        response.sendRedirect("index.jsp");
        return;
    } catch (Exception e) {
        out.println("Error al guardar: " + e.getMessage());
    }
}

// Actualizar existente
if (request.getParameter("Actualizar") != null) {
    String idActualizar = request.getParameter("id_programador");
    String nombre = request.getParameter("nombre");
    String lenguajeD = request.getParameter("lenguajeD");
    String lenguajeC = request.getParameter("lenguajeC");
    int estudiante = request.getParameter("estudiante") != null ? 1 : 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/programadores", "root", "");
        st = con.createStatement();
        String sql = "UPDATE tblprogramadores SET nombre='" + nombre + "', lenguajeD='" + lenguajeD + "', lenguajeC=" + lenguajeC + ", estudiante=" + estudiante + " WHERE id_programador=" + idActualizar;
        st.executeUpdate(sql);
        response.sendRedirect("index.jsp");
        return;
    } catch (Exception e) {
        out.println("Error al actualizar: " + e.getMessage());
    }
}
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Gestión de Programadores</a>
  </div>
</nav>

<div class="container mt-5">
    <div class="row">
        <!-- Formulario -->
        <div class="col-md-4">
            <h4><%= idEditar != null ? "Editar Programador" : "Registrar Programador" %></h4>
            <form method="post" action="index.jsp">
                <input type="hidden" name="id_programador" value="<%= idEditar != null ? idEditar : "" %>">
                <div class="mb-3">
                    <label>Nombre</label>
                    <input type="text" class="form-control" name="nombre" placeholder="Andres Gonzalez" value="<%= nombreEditar != null ? nombreEditar : "" %>" required>
                </div>
                <div class="mb-3">
                    <label>Lenguaje que más domina</label>
                    <input type="text" class="form-control" name="lenguajeD" value="<%= lenguajeDEditar != null ? lenguajeDEditar : "" %>" placeholder="Java" required>
                </div>
                <div class="mb-3">
                    <label>Cantidad de lenguajes que conoce</label>
                    <input type="number" class="form-control" name="lenguajeC" value="<%= lenguajeCEditar != null ? lenguajeCEditar : "" %>" placeholder="2" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="estudiante" name="estudiante" value="1" <%= "Sí".equals(estudianteEditar) || "1".equals(estudianteEditar) ? "checked" : "" %>>
                    <label class="form-check-label" for="estudiante">Estudiante</label>
                </div>
                <button type="submit" class="btn btn-outline-primary" name="<%= idEditar != null ? "Actualizar" : "Guardar" %>">
                    <%= idEditar != null ? "Actualizar" : "Guardar" %>
                </button>
            </form>
        </div>

        <!-- Tabla -->
        <div class="col-md-8">
            <h2>Programadores Registrados</h2>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Lenguaje que domina</th>
                        <th>Cantidad que conoce</th>
                        <th>Estudiante</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/programadores", "root", "");
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM tblprogramadores");

                    while(rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("id_programador") %></td>
                        <td><%= rs.getString("nombre") %></td>
                        <td><%= rs.getString("lenguajeD") %></td>
                        <td><%= rs.getInt("lenguajeC") > 1 ? "muchos" : rs.getInt("lenguajeC") %></td>
                        <td><%= rs.getInt("estudiante") == 1 ? "Sí" : "No" %></td>
                        <td>
                            <a href="index.jsp?id_programador=<%= rs.getInt("id_programador") %>&nombre=<%= rs.getString("nombre") %>&lenguajeD=<%= rs.getString("lenguajeD") %>&lenguajeC=<%= rs.getInt("lenguajeC") %>&estudiante=<%= rs.getInt("estudiante") == 1 ? "Sí" : "No" %>" class="btn btn-outline-warning btn-sm">
                                <i class="fa-solid fa-pencil"></i> 
                            </a>
                            <button class="btn btn-outline-danger btn-sm">
                                <i class="fa-solid fa-trash"></i> 
                            </button>
                        </td>
                    </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException ex) {}
                    try { if (st != null) st.close(); } catch (SQLException ex) {}
                    try { if (con != null) con.close(); } catch (SQLException ex) {}
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

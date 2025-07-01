<%@page import="dao.ProgramadorDAO" %>
<%@page import="modelo.Programador" %>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String nombre = request.getParameter("nombre");
        String lenguajeD = request.getParameter("lenguajeD");
        int lenguajeC = Integer.parseInt(request.getParameter("lenguajeC"));
        String password = request.getParameter("password");
        int estudiante = request.getParameter("estudiante") != null ? 1 : 0;

        Programador p = new Programador();
        p.setNombre(nombre);
        p.setLenguajeD(lenguajeD);
        p.setLenguajeC(lenguajeC);
        p.setPassword(password);
        p.setEstudiante(estudiante);

        new ProgramadorDAO().insertar(p);
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Programador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h1>Crear Programador</h1>
    <form method="post">
        <div class="mb-3">
            <label>Nombre</label>
            <input name="nombre" class="form-control" placeholder="Nombre">
        </div>
        <div class="mb-3">
            <label>Lenguaje Dominante</label>
            <input name="lenguajeD" class="form-control" placeholder="Lenguaje">
        </div>
        <div class="mb-3">
            <label>Cantidad de Lenguajes</label>
            <input name="lenguajeC" type="number" class="form-control">
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input name="password" type="password" class="form-control">
        </div>
        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" name="estudiante" id="estudiante">
            <label class="form-check-label" for="estudiante">Estudiante</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
    </form>
</body>
</html>

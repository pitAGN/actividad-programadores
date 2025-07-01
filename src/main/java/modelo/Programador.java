package modelo;

public class Programador {
    private int id;
    private String nombre;
    private String lenguajeD;
    private int lenguajeC;
    private String password;
    private int estudiante;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getLenguajeD() { return lenguajeD; }
    public void setLenguajeD(String lenguajeD) { this.lenguajeD = lenguajeD; }

    public int getLenguajeC() { return lenguajeC; }
    public void setLenguajeC(int lenguajeC) { this.lenguajeC = lenguajeC; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public int getEstudiante() { return estudiante; }
    public void setEstudiante(int estudiante) { this.estudiante = estudiante; }
}

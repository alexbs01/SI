package es.udc.sistemasinteligentes;

public class Nodo {
    private Estado e;
    private Nodo p;
    private Accion a;

    public Nodo(Estado e, Nodo p, Accion a) {
        this.e = e;
        this.p = p;
        this.a = a;
    }


}

// Jonathan Menéndez 18023
// Proyecto de FSM : Testbench
// Electrónica Digital 1

module testbench();
  reg clk;
  reg S, T, H, R, J;
  reg B;
  reg [1:0]P;
  wire I, E0, F, K, G, V, A, E3;
  wire [2:0]E1, E2, M1, M2;

  Proyecto_FSM Y (clk, S, I, E0, T, H, F, K, E1, M1, R, J, P, G, V, E2, M2, B, A, E3);

initial begin
  clk = 1;
  S = 0; T = 0; H = 0; P = 0; R = 0; J = 0; B = 0;

 // display de las entradas y salidas de la FSM

  $display ("\t\t Time \t S \t T \t H \t K \t P1 \t P0 \t R \t J \t G \t A \t E0 \t E1 \t E2 \t E3 \t M1 \t M2 \t V \t F \t I");
  $monitor ("%d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t", $time, S, T, H, K, P[1], P[0], R, J, G, A, E0, E1, E2, E3, M1, M2, V, F, I);
  #5 S = 1; T =1; H = 1;           //delays
  #5 T = 0; B = 1;
  #1 B = 0;
  #4 B = 1;
  #5 B = 0; P[0] = 1;
  #5 P[0] = 0; R = 1; J = 1;
  #5 R = 0; J = 0; B = 1;
  #5 B = 0;
  #5 S = 0;
  #5 $finish;

end

  always
    #0.5 clk =~clk;   //ingreso del flanco de reloj

initial
  begin
    $dumpfile("ProyectoFSM_tb.vcd");      // Abrir GTKWave para diagramas de timing
    $dumpvars (1);
  end

endmodule

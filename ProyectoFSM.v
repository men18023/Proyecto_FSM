// Jonathan Menéndez 18023
// Proyecto de FSM : Diseño
// Electrónica Digital 1

// Codificación usada para el proyecto:
  // E0 = Talanquera
  // E1 = Sistema
  // E2 = Pago
  // E3 = Debouncing

//Ingreso de módulos del proyecto.

module Proyecto_FSM (
  input	clk, S,					    // Talanquera
  output I, E0,

  input T, H,				       	// Sistema
  output F, K,
  output [2:0]E1, M1,

  input R, J,
  input [1:0]P,			        // Pago
  output G, V,
  output [2:0]E2, M2,

  input B,					       	// Debouncing
  output A,E3
	);

  wire I, V;
  wire [2:0] M1, M2;
  reg E0 = 0;
  reg [2:0]E1 = 0;
  reg [2:0]E2 = 0;
  reg E3 = 0;
  reg A = 0; reg G = 0; reg K = 0;  reg F = 0;


  // valores para FSM Talanquera
  assign I = E0;

  // valores para FSM Sistema de parqueo
  assign M1[2] = E1[2] & E1[0];
  assign M1[1] = E1[1];
  assign M1[0] = (~E1[2] & E1[0]) | (E1[2] &~ E1[0]);

  // valores para FSM Pago
  assign M2[2] = E2[2] & ~E2[1] & E2[0];
  assign M2[1] = (~E2[2] & E2[1]) | (E2[1] & ~E2[0]);
  assign M2[0] = (~E2[2] & E2[0]) | (E2[2] & E2[1] & ~E2[0]);
  assign V = E2[2] & ~E2[1] & E2[0];


  always @ (posedge clk)
    begin

      // Talanquera
      E0 <= (~E0&F) | (E0&S);

      // Sistema
      E1[2] <= (E1[2]&~E1[0]) | (E1[2]&S) | (E1[1]&E1[0]&A);
      E1[1] <= (E1[1]&~E1[0]) | (~E1[2]&~E1[1]&E1[0]) | (~E1[2]&E1[0]&~A);
      E1[0] <= (E1[1]&~E1[0]&A) | (E1[1]&E1[0]&~A) | (E1[2]&~E1[0]&G) | (E1[2]&E1[0]&S) | (~E1[2]&~E1[1]&~E1[0]&T) | (~E1[2]&~E1[1]&E1[0]&~H);
      K <= E1[2] & ~E1[0];
      F <= E1[2] & E1[0];

      // Pago
      E2[2] <= (E2[2]&~E2[1]) | (E2[2]&~E2[0]) | (E2[2]&S) | (~E2[1]&E2[0]&P[1]&~P[0]) + (~E2[2]&E2[1]&E2[0]&R);
      E2[1] <= (E2[2]&E2[1]&~E2[0]) | (E2[2]&~E2[0]&~J) | (E2[2]&E2[1]&S) | (~E2[2]&~E2[1]&E2[0]&P[1]) | (~E2[2]&~E2[1]&E2[0]&P[0]) | (~E2[2]&E2[1]&E2[0]&~R) | (E2[2] &~E2[1]&E2[0]&A);
      E2[0] <= 	(E2[2]&~E2[1]) | (~E2[1]&E2[0]&~P[1]) | (~E2[2]&E2[1]&~R) | (~E2[1]&~E2[0]&K) | (E2[1]&~E2[0]&R) | (E2[2]&E2[0]&S);
      G = E2[2] & E2[1] & E2[0];

      // Debouncing
      E3 <= B;
      A <= ~E3 & B;

    end

endmodule

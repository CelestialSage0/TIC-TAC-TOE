`include "TCell.v"

module TBox (
    input clk, set, reset, input [1:0] row, input [1:0] col, output [8:0] valid, output [8:0] symbol, output reg [1:0] game_state
);
    reg player;
    wire [3:0] index;

    reg [8:0] cell_set;

    initial begin
        game_state <= 2'b00;
        player <= 1;
        cell_set = 9'b0;
    end
    assign index = (row - 2'b01)*3 + (col - 2'b01);

    TCell cells[8:0](.clk(clk), .set(cell_set), .reset(reset), .set_symbol(!player), .valid(valid), .symbol(symbol));

    always @(posedge clk) begin
        if (
            (valid[0] && symbol[0] == symbol[1] && symbol[1] == symbol[2]) ||
            (valid[3] && symbol[3] == symbol[4] && symbol[4] == symbol[5]) ||
            (valid[6] && symbol[6] == symbol[7] && symbol[7] == symbol[8]) ||

            (valid[0] && symbol[0] == symbol[3] && symbol[3] == symbol[6]) ||
            (valid[1] && symbol[1] == symbol[4] && symbol[4] == symbol[7]) ||
            (valid[2] && symbol[2] == symbol[5] && symbol[5] == symbol[8]) ||

            (valid[0] && symbol[0] == symbol[4] && symbol[4] == symbol[8]) ||
            (valid[2] && symbol[2] == symbol[4] && symbol[4] == symbol[6])
        ) begin
            game_state = (player==0) ? 2'b01 : 2'b10;
        end else if (&valid) begin
            game_state = 2'b11;
        end 
        else begin
            game_state = 2'b00;
        end
    end

    always @(posedge clk) begin
        if (reset==1) begin
            player<=1;
            game_state = 2'b00;
            cell_set = 9'b0;
        end
        else if (set==1 && game_state==2'b00) begin
            if (!valid[index]) begin    
                // valid[index] <= 1'b1;
                // symbol[index] <= (player==1) ? 1'b1 : 1'b0;
                // cells[index].set <= 1;
                // cells[index].set_symbol <= player;
                cell_set[index] = 1'b1;

                player <= ~player;
            end
        end
    end
endmodule
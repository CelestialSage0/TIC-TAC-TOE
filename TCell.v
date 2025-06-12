module TCell (
    input clk, set, reset, set_symbol, output reg valid, symbol
);
    initial begin
     valid=0;
    end
    always @(posedge clk) begin
            if(reset==1) begin
                valid=0;
            end
            else begin
                if(set==1 && valid==0) begin
                valid=1;
                symbol = set_symbol;
                end
            end
        end
endmodule
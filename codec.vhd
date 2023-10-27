library ieee, std;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;

entity codec is
port (
interrupt      : in std_logic; -- Interrupt signal
read_signal    : in std_logic; -- Read signal
write_signal   : in std_logic; -- Write signal
valid          : out std_logic; -- Valid signal

codec_data_in  : in std_logic_vector(7 downto 0); -- Byte written to codec
codec_data_out : out std_logic_vector(7 downto 0) -- Byte read from codec
);
end entity;

architecture behavioral of codec is   
begin
read_input_file: process (interrupt)    
    --open the input file and the output file
    file input_file  : text open read_mode is "input_file.dat";
    file output_file : text open write_mode is "output_file.dat";
    --variables to get and set the values of reading and writing 
    variable data_line_read, data_line_write : line;
    variable data_read, data_write           : integer range 0 downto 255;
    variable g : boolean;
    --variable data_read_string, data_write_string : string(8 downto 1);

    begin
             
        if read_signal = '1' and write_signal = '0' then
            readline(input_file, data_line_read); 
            read(data_line_read, data_read, g);
            codec_data_out <= std_logic_vector(to_signed(data_read, codec_data_out'length));
            valid <= '1';

        elsif read_signal = '0' and write_signal = '1' then
            data_write := to_integer(signed(codec_data_in));
            write(data_line_write, data_write);
            writeline(output_file, data_line_write);
            valid <= '1';
        end if;
end process;    

end architecture;
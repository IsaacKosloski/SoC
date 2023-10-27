library ieee;
use ieee.std_logic_1164.all;

entity tb_codec is
end entity;

architecture mixed of tb_codec is
    signal interrupt, read_signal, write_signal, valid : std_logic;
    signal  codec_data_in, codec_data_out              : std_logic_vector(7 downto 0);
begin
    codec: entity work.codec(behavioral)
        port map(interrupt, 
                read_signal,
                write_signal,
                valid,
                codec_data_in,
                codec_data_out);

        codec_test: process is
        begin
            -- Initialize signals
            interrupt <= '0';
            read_signal <= '0';
            write_signal <= '0';
            valid <= '0';
            codec_data_in <= (others => '0');

            wait for 10 ns;

            -- Start reading data
            read_signal <= '1';
            
            wait for 10 ns;

            -- Simulate data read
            codec_data_out <= "11011010";
            valid <= '1';
            
            wait for 10 ns;

            -- Stop reading
            read_signal <= '0';
            valid <= '0';
            wait for 10 ns;

            -- Start writing data
            write_signal <= '1';
            wait for 10 ns;

            -- Simulate data write
            codec_data_in <= "10101010";
            valid <= '1';
            wait for 10 ns;

            -- Stop writing
            write_signal <= '0';
            valid <= '0';
            
            report "Fim dos testes";

            -- Finish the simulation
            wait;
        end process;
end architecture;


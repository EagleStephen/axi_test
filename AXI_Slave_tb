-- Testbench for AXI memory slave module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI_Slave_tb is
end AXI_Slave_tb;

architecture Behavioral of AXI_Slave_tb is
    signal clk : std_logic := '0'; -- clock signal
    signal reset : std_logic := '1'; -- reset signal
    signal req : std_logic := '0'; -- read/write request signal
    signal ack : std_logic; -- acknowledgement signal
    signal Rdata : std_logic_vector(31 downto 0); -- read data signal
    signal Wdata : std_logic_vector(31 downto 0) := x"01234567"; -- write data signal
    signal address : std_logic_vector(31 downto 0) := x"00000000"; -- memory address
    signal R_W : std_logic := '0'; -- read/write permission signal
    component AXI_Slave is
        port (
            clk : in std_logic;
            reset : in std_logic;
            req : in std_logic;
            ack : out std_logic;
            Rdata : out std_logic_vector(31 downto 0);
            Wdata : in std_logic_vector(31 downto 0);
            address : in std_logic_vector(31 downto 0);
            R_W : in std_logic
        );
    end component;
begin
    DUT: AXI_Slave
    port map (
        clk => clk,
        reset => reset,
        req => req,
        ack => ack,
        Rdata => Rdata,
        Wdata => Wdata,
        address => address,
        R_W => R_W
    );

    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        req <= '1'; -- read request
        address <= x"00000000"; -- read from memory location 0
        R_W <= '0'; -- read permission
        wait for 10 ns;
        assert Rdata = x"00000000" report "Read data incorrect" severity error;
        assert ack = '1' report "Acknowledgement signal incorrect" severity error;
        req <= '1'; -- write request
        address <= x"00000004"; -- write to memory location 4
        R_W <= '1'; -- write permission
        wait for 10 ns;
        assert ack = '1' report "Acknowledgement signal incorrect" severity error;
        req <= '1'; -- read request
        address <= x"00000004"; -- read from memory location 4
        R_W <= '0'; -- read permission
        wait for 10 ns;
        assert Rdata = x"01234567" report "Read data incorrect" severity error;
        assert ack = '1' report "Acknowledgement signal incorrect" severity error;
        wait;
    end process;

    -- Clock generation
    process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;
end Behavioral;

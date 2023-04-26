-- AXI memory slave module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AXI_Slave is
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
end AXI_Slave;

architecture Behavioral of AXI_Slave is
    signal mem : std_logic_vector(31 downto 0); -- memory to store data
begin
    process(clk, reset)
    begin
        if reset = '1' then -- reset signal is active high
            mem <= (others => '0');
            ack <= '0';
        elsif rising_edge(clk) then -- read and write operations on rising edge of the clock
            if req = '1' then -- read or write request from the master
                if R_W = '0' then -- read operation
                    Rdata <= mem(to_integer(unsigned(address))); -- read data from memory
                    ack <= '1'; -- acknowledge the read request
                else -- write operation
                    mem(to_integer(unsigned(address))) <= Wdata; -- write data to memory
                    ack <= '1'; -- acknowledge the write request
                end if;
            else
                ack <= '0'; -- no request from the master, no acknowledgement
            end if;
        end if;
    end process;
end Behavioral;

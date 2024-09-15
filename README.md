# fpga_a7-lite_uart

This is an UART (Universal Asynchronous Receiver Transmitter)  TX (Transmitter from FPGA to PC) example for MicroPhase A7-Lite FPGA board with an XC7A100T (Artix-7) FPGA.

When creating a Vivado project, please select **xc7a100tfgg484-1** as an FPGA.

MicroPhase A7-Lite FPGA board has a **CH340E** chip (USB to serial chip).
Please install the CH304E device driver on your computer.

Please set the communication speed to 1Mbaud.　
The character 'a' will be sent periodically to the terminal.

![uart](https://github.com/user-attachments/assets/9b2a576d-fb0c-4dbe-84ca-684e8acfd4c4)


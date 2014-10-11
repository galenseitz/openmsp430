/*===========================================================================*/
/* Copyright (C) 2001 Authors                                                */
/*                                                                           */
/* This source file may be used and distributed without restriction provided */
/* that this copyright statement is not removed from the file and that any   */
/* derivative work contains the original copyright notice and the associated */
/* disclaimer.                                                               */
/*                                                                           */
/* This source file is free software; you can redistribute it and/or modify  */
/* it under the terms of the GNU Lesser General Public License as published  */
/* by the Free Software Foundation; either version 2.1 of the License, or    */
/* (at your option) any later version.                                       */
/*                                                                           */
/* This source is distributed in the hope that it will be useful, but WITHOUT*/
/* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     */
/* FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public       */
/* License for more details.                                                 */
/*                                                                           */
/* You should have received a copy of the GNU Lesser General Public License  */
/* along with this source; if not, write to the Free Software Foundation,    */
/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA        */
/*                                                                           */
/*===========================================================================*/
/*                               CLOCK MODULE                                */
/*---------------------------------------------------------------------------*/
/* Sandbox test                                                              */
/*                                                                           */
/* Author(s):                                                                */
/*             - Olivier Girard,    olgirard@gmail.com                       */
/*                                                                           */
/*---------------------------------------------------------------------------*/
/* $Rev: 19 $                                                                */
/* $LastChangedBy: olivier.girard $                                          */
/* $LastChangedDate: 2009-08-04 23:47:15 +0200 (Tue, 04 Aug 2009) $          */
/*===========================================================================*/


task mstr_write;
   input  [15:0] addr;
   input  [15:0] data;
   
   begin      
      mstr_mem_en   = 1'b1;
      mstr_mem_we   = 2'b00;
      mstr_mem_addr = addr;
      mstr_mem_din  = data;
      @(posedge mclk);
      while(~mstr_ready) @(posedge mclk);
      mstr_mem_en   = 1'b0;
      mstr_mem_we   = 2'b00;
      mstr_mem_addr = 16'h0000;
      mstr_mem_din  = 16'h0000;
   end
endtask


initial
   begin
      $display(" ===============================================");
      $display("|                 START SIMULATION              |");
      $display(" ===============================================");
      
      repeat(5) @(posedge mclk);
 
      stimulus_done = 0;

      repeat(50) @(posedge mclk);
           
      mstr_write(16'hF800, 16'h1234);
      mstr_write(16'hF804, 16'h5678);

      repeat(50) @(posedge mclk);

      stimulus_done = 1;
   end

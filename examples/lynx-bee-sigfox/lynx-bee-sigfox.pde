
/*
    ------ LYNX BEE MODULE BURN IN TEST --------

    Copyright (C) 2017 Walyt Technologies Pty Ltd
    https://walt-tech.com.au

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Put your libraries here (#include ...)

#include <LYNXBeeSigfox.h>

// Use Socket 1 on waspmote (riser need on waspmote board). Using Socket 1 means you get use SOCKET 0 for debug USB Messages

uint8_t socket = SOCKET1;
uint8_t error = 0;

// data to send we send 8, 10 and 12 byte loads. 

uint8_t sf_data_count = 0;
byte SigfoxPayload_8Bytes[]= {"aa11ff99"};
byte SigfoxPayload_10Bytes[]= {"bb22ee88cc"};
byte SigfoxPayload_12Bytes[]= {"dd77ee66ff55"};

// instantiate the Sigdox Module. 

LYNXBeeSigfox XbeeSigfoxFModule = LYNXBeeSigfox();

void setup() 
{

  uint8_t sf_id = 0;
  uint8_t sf_pac = 0;

  
  USB.ON();  
  USB.println();

  //////////////////////////////////////////////
  // switch on
  //////////////////////////////////////////////
  error = XbeeSigfoxFModule.ON(socket);
  
  // Check status
  if( error == 0 ) 
  {
    USB.println(F("Switch ON OK"));     
    sf_id = XbeeSigfoxFModule.getID();
    sf_pac = XbeeSigfoxFModule.getPAC();
    USB.println("Have you registered the module in the Sigfox Backend??? backend.sigfox.com");
    USB.print("Your Sigfox Module ID is: ");
    USB.println(XbeeSigfoxFModule._id, HEX);
    USB.print("Your Sigfox Module PAC is: ");
    USB.println(XbeeSigfoxFModule._pac, HEX);     
  }
  else 
  {
    USB.println(F("Switch ON ERROR")); 
  } 


  USB.println();
}


void loop()
{
  // we will send 3 messages continuosly with 10 seconds between message we will then sleep for 10 minutes and send another 3 messges at 10 seconds between each message

  sf_data_count = sf_data_count +1;
    
  // Check status
  error = XbeeSigfoxFModule.ON(socket);
  printResults();
  
  error = XbeeSigfoxFModule.send(SigfoxPayload_8Bytes,8);
  printResults();
  delay(5000);
 
  error = XbeeSigfoxFModule.send(SigfoxPayload_10Bytes,10);
  printResults();
  delay(5000);
 
  error = XbeeSigfoxFModule.send(SigfoxPayload_12Bytes,12);
  printResults();
  delay(5000);

  error = XbeeSigfoxFModule.OFF(socket);
  printResults();
  delay(600000);
  
}


//helper function - print results

void printResults()
{
USB.print("The value of the Error Code is:");
USB.println(error);


}


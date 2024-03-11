//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Ticket {

    struct TicketEvent {
        string EventName;
        uint256 Price;
        address Owner;
        bool isUsed;
    }

    mapping(uint256 => TicketEvent) public tickets;
    uint256 ticketId = 0;
    
    function createTicket(string calldata eventName_, uint256 price_) public {
        ticketId++;
        tickets[ticketId] = TicketEvent(eventName_, price_, msg.sender, false);
    }

    function buyTicket(uint256 ticketId_) public payable {
        require(ticketId_ != 0, "Ticket Invalido");
        require(msg.value >= tickets[ticketId_].Price, "Valor insuficiente");
        tickets[ticketId_].Owner =  msg.sender;
    }

    function useTicket(uint256 ticketId_) public {
        require(tickets[ticketId_].Owner == msg.sender, "Vc nao e o dono deste Ticket");
        require(!tickets[ticketId_].isUsed, "Ticket ja usado");

        tickets[ticketId_].isUsed = true;
    }
}
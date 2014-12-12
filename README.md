# REPL for Mailchimp API v2.0

A REPL for quick and easy interaction with the Mailchimp API

Basically just a curl wrapper under the hood

Works only with JSON for the time being

## Usage
call `chimp` to enter the REPL

Syntax is like:  
`<command> [<json>]`

Examples:  
`lists/list`  
`lists/members {"id": "xyz"}`

## Installation
`sudo cp chimp.sh /usr/local/bin/chimp`

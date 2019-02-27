#!/bin/bash
ACCESS_TOKEN=...
AMBASSADOR_URL=192.168.99.100:31314

# Valid test
curl http://${AMBASSADOR_URL}/hello/mo \
 --header "Authorization: Bearer ${ACCESS_TOKEN}"

 # No Header
 curl http://${AMBASSADOR_URL}/hello/mo

 # Invalid Bearer
 curl http://${AMBASSADOR_URL}/hello/mo \
 --header "Authorization: Bearer fakeJwt"
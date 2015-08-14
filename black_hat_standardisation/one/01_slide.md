!SLIDE
# **Black-Hat Standardisation** #
## Or, Who Watches The Watchmen?

!SLIDE
Alice & Bob want to communicate securely

!SLIDE
But what ciphers should they use?

!SLIDE
DES? RSA? AES?

!SLIDE
Consult the standards: NIST, IEEE, Brainpool, ANSI, ISO

!SLIDE
But what if the standards bodies are **wrong**?

!SLIDE
Or **malicious?**

!SLIDE
Example: 1992, NIST proposed standard was DSS

!SLIDE
Has a major flaw: generation of random number *k* must be implemented properly

!SLIDE
NIST gives no guidance on how to do this

!SLIDE
*“The poor user is
given enough rope with which
to hang himself—something
a standard should not do”*   
Rivest, 1992

!SLIDE
2006, Dual Elliptic-Curve DRBG is standardised by NIST

!SLIDE
Algorithm could harbour a backdoor advantageous only to the designers

!SLIDE
2013, NYT reported Snowden memos that NSA had worked during the
standardisation process to become the sole editor of Dual EC

!SLIDE
2014, NIST withdrew Dual EC from guidance on random number generators

!SLIDE
# Other control methods

!SLIDE
Take control of the standards: propose 20 weak standards, some will
survive

!SLIDE
Manipulate the selection

!SLIDE
Deter publication of weaknesses

!SLIDE
Manipulate security criteria

!SLIDE
# Your chosen PRNG becomes part of the standard

!SLIDE
*“There's no way the NSA/GCHQ can read my encrypted WhatsApp/Signal
messages!”*

!SLIDE
What if the NSA/GCHQ manipulated the process so the encryption is
already able to be broken by them?

!SLIDE
Unlikely?

!SLIDE
*“... are we going to allow a means of
communications which it simply isn't possible to read.
My answer to that question is: "No we must not".”*   
2015, David Cameron


!SLIDE bullets
Sources

* Rivest, 1992: https://people.csail.mit.edu/rivest/pubs/RHAL92.pdf
* &nbsp;
* http://www.theguardian.com/world/2013/sep/05/nsa-gchq-encryption-codes-security
* &nbsp;
* Bernstein et al, 2015: https://bada55.cr.yp.to/

!SLIDE
# Questions?

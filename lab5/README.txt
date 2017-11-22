Your Lab 5 work *must* be done in this directory.
Justin Tahara
jltahara@ucsc.edu 
1524347
Lab 5 - Vigenere Cipher
02C Michael Powell
Due 11/26/17

For the encode algorithm I analyzed the given C code and made an algorithm that took the first byte of the key and the text and adds them together. Then once the sum is found it is divided by 128 which is the amount ascii characters there is. Once the sum is divided, the remainder is printed out which will be the encrypted text. The bytes for the key and text are shifted to the next byte over but the key has to repeat so there is another loop to reset the key bytes. Once the text gets to the last byte it moves on to the decoder.

For the decoder the algorithm is very similar. The sums are found and it is divided by 128 like before. The remainder is the same number as the encoder but from there you subtract the value of the key which will result in a negative number. Once that number is stored, you add 128 again to the number stored to get the value of the decrypted value again.

In order to make the algorithms to work I used the load word function in order to store the inputs into certain terminals and later on used move to store the inputed values into a separate terminal to make a copy. Using load byte, I got each individual byte and added them together. Stored the sum. Divided by 128 which was described before. As described before the functions for both the encode and decode changes but the numbers are usually temporarily saved and the only value that never changes is the inputed values from the user. 
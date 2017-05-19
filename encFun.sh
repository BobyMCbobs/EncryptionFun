#!/bin/bash

##
#
# v1.0
#
# This is a simple text and file encryption program
# You can encrypt and decrypt [1] text files (made within this program)...
# [2] files, and [3] compress and encrypt archives (folders)
#
# This program has absolutely no warranty... things may break, so just follow along with instructions (I have made some failsafes just incase)
#
# This program uses aes-256-ecb 's encryption algorithm via the openssl command.
#
# Yours, BobyMCbobs of https://github.com/BobyMCbobs
#
# 	 ________
#	 < Enjoy! >
#	 --------
#	        \   ^__^
#	         \  (oo)\_______
#	            (__)\       )\/\
#	               ||----w |
#	               ||     ||
#
##

tempf1=".tempDec.txt"

if [ -f $tempf1 ]
then

	rm .tempDec.txt

fi

function eodp {

echo -n "Do you want to Encrypt, Decrypt, Modify, need Help, or eXit? "
read soption

if [ $soption = E ] || [ $soption = Encrypt ] || [ $soption = Enc ] || [ $soption = e ] || [ $soption = encrypt ]
then

	echo -n "Do you want to create a New text file, or encrypt a Currently existing one? "
	read ntfoeno

	if [ $ntfoeno = N ] || [ $ntfoeno = n ] || [ $ntfoeno = new ] || [ $ntfoeno = New ]
	then

		echo -n "Enter a message here: "
        	sleep 0.4
 		nano .encmsg.txt
		ckempt=$(du -h .encmsg.txt | cut -b 1)

	elif [ $ntfoeno = C ] || [ $ntfoeno = c ] || [ $ntfoeno = current ] || [ $ntfoeno = Current ]
	then

		echo -n "Is it a Text file, or just a File, or a folder to Archive and encrypt? "
		read tfonf

		if [ $tfonf = t ] || [ $tfonf = T ] || [ $tfonf = text ] || [ $tfonf = Text ]
		then

                	echo -n "What is it called? "
                	read ctxtf

			echo -n "What name would you like to give it? (.txt added automatically) "
        		read otext

        		if [ -z $otext ]
        		then

                		echo "No name given, it's name will automatically be 'mymsg.txt'"

                		otext="mymsg"

        		fi

		cat $ctxtf | openssl aes-256-ecb -a -salt -out $otext.txt

		toview

        	checkiffinished


		echo -n "What name would you like to give it? (.txt added automatically) "
		read otext

		if [ -z $otext ]
		then

			echo "No name given, it's name will automatically be 'mymsg.txt'"

			otext="mymsg"

		fi

		cat .encmsg.txt | openssl aes-256-ecb -a -salt -out $otext.txt
		rm .encmsg.txt

		elif [ $tfonf = f ] || [ $tfonf = F ] || [ $tfonf = file ] || [ $tfonf = File ]
       		then

			echo -n "What is it called? "
                	read ctxtf

			echo -n "What name would you like to give it? "
                        	read otextf

                        	if [ -z $otextf ]
                        	then

                         	       echo "No name given, it's name will automatically be 'myfile'"

                         	       otext="myfile"

                       		fi

                        	openssl aes-256-ecb -a -salt -in $ctxtf -out $otextf
				echo "Encryption complete"

                        	tolist

                        	checkiffinished
		elif [ $tfonf = a ] || [ $tfonf = A ] || [ $tfonf = Archive ] || [ $tfonf = archive ]
                then
			aae


                else
                        echo "Please enter a correct answer... "

              	fi

	else

		echo "Incorrect answer... please answer correctly."
		eodp

	fi

                if [ ! -f .encmsg.txt ]
                then
			echo "You didn't save anything... can't encrypt it if it's not saved!"
			ckempt=""
			eodp

		fi

		if [ $ckempt = '0' ]
		then

			echo "You didn't write anything... no need to encrypt a blank file!"
			rm .encmsg.txt
                	eodp

		fi

		if [ -f .encmsg.txt ]
                then

	echo -n "What name would you like to give it? (.txt added automatically) "
        	read otext

        	if [ -z $otext ]
        	then

         	       echo "No name given, it's name will automatically be 'mymsg.txt'"

         	       otext="mymsg"

        	fi

        	cat .encmsg.txt | openssl aes-256-ecb -a -salt -out $otext.txt
        	rm .encmsg.txt


	toview

	checkiffinished

	fi


elif [ $soption = D ] || [ $soption = Decrypt ] || [ $soption = Dec ] || [ $soption = d ] || [ $soption = decrypt ]
then
	echo -n "Is it a Text file, just a File, or an Archive? "
	read tfonf

	if [ $tfonf = t ] || [ $tfonf = T ] || [ $tfonf = text ] || [ $tfonf = Text ]
	then

		echo -n "What's the file to decrypt called (don't add extention, file must end with .txt)? "
        	read text


		if [ -f $text.txt ]
		then
			echo "Found: '$text.txt'"
			stxt

		else
			echo "'$text' doesn't exist"
			eodp

		fi

	elif [ $tfonf = f ] || [ $tfonf = F ] || [ $tfonf = file ] || [ $tfonf = File ]
	then

		echo -n "What's the file to decrypt called? "
	        read text


		if [ -f $text ]
        	then
          	      echo "Found: '$text'"
         	       stxt

        	else
         	       echo "'$text' doesn't exist"
         	       eodp

       		fi

	elif [ $tfonf = a ] || [ $tfonf = A ] || [ $tfonf = archive ] || [ $tfonf = Archive ]
	then
		dae

	else
		echo "Please answer correctly..."
		eodp

	fi

elif [ $soption = X ] || [ $soption = Exit ] || [ $soption = x ]
then

exit

elif [ $soption = m ] || [ $soption = Modify ] || [ $soption = m ] || [ $soption = modify ]
then
	echo -n "What's your text file called? "
	read mde

	openssl aes-256-ecb -a -d -salt -in $mde.txt -out .modmsg.txt
	cat .modmsg.txt > .modmsgt.txt
	nano .modmsg.txt

	changes1=`cksum .modmsg.txt | awk -F" " '{print $1}'`
	changes2=`cksum .modmsgt.txt | awk -F" " '{print $1}' `

	if [ $changes1 = $changes2 ]
	then

		rm .modmsg*.txt

	else

		echo "Please type in a password to reencrypt your message: "
		openssl aes-256-ecb -a -salt -in .modmsg.txt -out .modmsg2.txt

		cat .modmsg2.txt > $mde.txt
		rm .modmsg*.txt

	fi

	checkiffinished

elif [ $soption = h ] || [ $soption = H ] || [ $soption = help ] || [ $soption = Help ]
then
	echo " "
	echo "----------"
	echo "This is a friendly program, it plays nice... so make sure you use it correctly."
	echo "----------"
	echo " "
	echo "[1] When selecting files and exporting files, you may give full directory listings..."
	echo "e.g. /home/[user]/test  ;  (file being test.txt)."
	echo "Relating to this is with text files, you can forget about file name extentions... no need to add .txt "
	echo " "
	echo "[2] This program uses strong AES-256 encryption, so if you lose the key(password) then you've lost the file, please keep that in mind."
	echo " "
	echo "[3] For menus you can type e.g. y, Y, yes, or Yes."
	echo "This is universal for all prompts."
	echo " "
	echo "[4] If you mistype and hit enter, you'll either be taken pack to the previous menu prompt or the root/main menu."
	echo " "
	echo "[5] If you want to quit at any time, press Ctrl^C. Keep in mind encFun.sh may leave some left overs such as unencrypted temp files, or corrupt the process if this happens."

	echo " "
	echo "Hit enter to return..."
	read hitentertoreturn
	eodp

else

	echo "Please type either 'E' for Encryption, or 'D' or Decryption, 'M' for Modify, 'H' for Help, or 'E' for eXit?"
	eodp

fi

}

function checkiffinished {

echo -n "Done? [Y|n] "
        read cnfmfmsg


if [ $cnfmfmsg = y ] || [ $cnfmfmsg = Y ] || [ $cnfmfmsg = Yes ] || [ $cnfmfmsg = yes ]
then

        exit

elif [ $cnfmfmsg = n ] || [ $cnfmfmsg = N ] || [ $cnfmfmsg = No ] || [ $cnfmfmsg = no ]
then

        eodp

else

        echo "Please answer: Yes or now... "
        checkiffinished
fi

}


function toview {

echo -n "View your text? "
        read vyt


if [ $vyt = y ] || [ $vyt = Y ] || [ $vyt = Yes ] || [ $vyt = yes ]
then

        less $otext.txt

elif [ $vyt = n ] || [ $vyt = N ] || [ $vyt = No ] || [ $vyt = no ]
then

        checkiffinished

else

        echo "Please answer: Yes or now... "
        toview
fi


}

function stxt {

if [ $tfonf = t ] || [ $tfonf = T ] || [ $tfonf = text ] || [ $tfonf = Text ]
then

echo -n "Do you want to Decrypt and save it, or just View it? "
        read sofd

        if [ $sofd = d ] || [ $sofd = D ] || [ $sofd = Decrypt ] || [ $sofd = decrypt ]
        then

                echo -n "What do you want to call it (don't add an extention, .txt will be added automatically)? "
                read otext

		openssl aes-256-ecb -a -d -salt -in $text.txt -out .tempDec.txt
               	cat .tempDec.txt > $otext.txt

		rtev
		toview

		rm .tempDec.txt

                checkiffinished

        elif [ $sofd = v ] || [ $sofd = V ] || [ $sofd = View ] || [ $sofd = view ]
        then

                openssl aes-256-ecb -a -d -salt -in $text.txt -out .$text.tempDec.txt

                less .$text.tempDec.txt

                rm .$text.tempDec.txt

                checkiffinished

        else
		echo "Please type, Yes or No... "
                stxt

        fi


elif [ $tfonf = f ] || [ $tfonf = F ] || [ $tfonf = file ] || [ $tfonf = File ]
then

        echo -n "What do you want to call it? "
	read otext

        openssl aes-256-ecb -a -d -salt -in $text -out $otext
        tolist

        checkiffinished

else
	echo "Please answer correctly... "
	stxt
fi


}


function ttoview {

echo -n "View your text? "
        read vyt


if [ $vyt = y ] || [ $vyt = Y ] || [ $vyt = Yes ] || [ $vyt = yes ]
then

        less .tempDec.txt

elif [ $vyt = n ] || [ $vyt = N ] || [ $vyt = No ] || [ $vyt = no ]
then

        checkiffinished

else

        echo "Please answer: Yes or now... "
        ttoview
fi


}


function tolist {

echo -n "List your file? "
        read vyt


if [ $vyt = y ] || [ $vyt = Y ] || [ $vyt = Yes ] || [ $vyt = yes ]
then

	du -h $otext
        ls -l | grep $otext

elif [ $vyt = n ] || [ $vyt = N ] || [ $vyt = No ] || [ $vyt = no ]
then

        checkiffinished

else

        echo "Please answer: Yes or now... "
        tolist
fi


}

function aae {

echo -n "Name the folder that you want to pack and encrypt: "
read topaf

if [ -d $topaf ]
then

	echo -n "What do you want to name the archive (end it with .tar)? "
	read archname

	tar -cvf .tmparch.tar $topaf
	echo "Compression complete"

	openssl aes-256-ecb -a -salt -in .tmparch.tar -out $archname
	rm .tmparch.tar

	echo "Encryption complete"

	checkiffinished

else

edop

fi

}

function dae {

echo "Name the encrypted archive that you want to decrypt and unpack (please include extention, will be .tar): "
read tardec

if [ -f $tardec ]
then
	echo "Found $tardec"

	openssl aes-256-ecb -d -a -salt -in $tardec -out .dectmptar.tar

	tar -xvf .dectmptar.tar
	echo "Extraction complete"
	rm .dectmptar.tar

else
	echo "Could not find $tardec"
	checkiffinished

fi

eodp
}

function rtev {

echo -n "Do you want to keep encryption version?"
read kefv

if [ $kefv = y ] || [ $kefv = Y ] || [ $kefv = Yes ] || [ $kefv = yes ]
then

	echo "Leaving... "

elif [ $kefv = n ] || [ $kefv = N ] || [ $kefv = No ] || [ $kefv = no ]
then

	rm $text.txt
	echo "Cleaning encrypted remains... "
else

	echo "Please answer correctly... "
	rtev
fi

}

eodp

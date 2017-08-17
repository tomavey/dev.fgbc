Registration Process

Create an empty shopping cart - session.shoppingcart[array]

When a person's first name is entered, use that as a temporary ID and create an array item for each itemselected as session.shoppingcart[{item:itemid, person:temporarypersonid, quanity:quantity}]

Before final checkout, get the rest of each persons info.  Load session.registrationcart.temporarypersonid{fname,lname,email,phone,key,gender,type(type of registration)}.

http://localhost:8888/rewrite.cfm/conference.-register/create-cart-items-from-form?440=5&person=sandi&cost=65


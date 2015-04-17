/*
   See blog post here for more details: http://jxf.me/entries/cheryls-birthday/
*/


/*
   Cheryl's Birthday

   A and B have just met Cheryl. "When is your birthday?" A asked Cheryl.
   
   Cheryl thought for a moment and said, "I won't tell you, but I'll give you some clues."

   She wrote down a list of 10 dates:

     May 15, May 16, May 19
     June 17, June 18
     July 14, July 16
     August 14, August 15, August 17

   "One of these is my birthday," she said.

   Cheryl whispered in A's ear the month, and only the month, of her birthday. 
   To B, she whispered the day, and only the day. 

   "Can you figure it out now?" she asked A.

   A: I don't know when your birthday is, but I know B doesn't know, either.
   B: I didn't know originally, but now I do.
   A: Well, now I know, too!

   When is Cheryl’s birthday?
*/

candidate_birthday(Month, Day) :-
  member(Month/Day,
    [
      'May'/15, 'May'/16, 'May'/19,
      'June'/17, 'June'/18,
      'July'/14, 'July'/16,
      'August'/14, 'August'/15, 'August'/17
    ]
  ).

/* true if month contains a day that uniquely decides month */
month_has_deciding_day(Month):- 
    candidate_birthday(Month, Day),
    findall(X, candidate_birthday(X, Day), [_]).

/* A: I don't know when your birthday is, but I know B doesn't know, either. */
s1(Month, Day):-
  /* must be a day that Cheryl specified */
  candidate_birthday(Month, Day),
  /* A doesn't know; so at least 2 birthdays in that month */
  findall(X, candidate_birthday(Month, X), [_, _ | _]),
  /* A knows B doesn't know; so month doesn't decide day */
  not(month_has_deciding_day(Month)).

/* B: I didn't know originally, but now I do. */
s2(Month, Day):- 
  /* must be a day that Cheryl specified */
  candidate_birthday(Month, Day),
  /* B now knows, so his day must uniquely decide the month */
  findall(X, s1(X, Day), [Month]).

/* A: Well, now I know, too! */
s3(Month, Day):-
  /* must be a day that Cheryl specified */
  candidate_birthday(Month, Day),
  /* A now knows, so his month must uniquely decide this day */
  findall(X, s2(Month, X), [Day]).

/* When is Cheryl’s birthday? */
birthday(Month, Day):- s3(Month, Day).

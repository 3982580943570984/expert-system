longevity(X, CF) :- menuask(longevity, X, CF, [very_weak, weak, moderate, long_lasting, eternal]).
sillage(X, CF) :- menuask(sillage, X, CF, [intimate, moderate, strong, enormous]).
gender(X, CF) :- menuask(gender, X, CF, [female, more_female, unisex, more_male, male]).
price(X, CF) :- menuask(price, X, CF, [way_overpriced, overpriced, ok, good_value, great_value]).
volume(X, CF) :- menuask(volume, X, CF, [small, medium, big]).
concentration(X, CF) :- menuask(concentration, X, CF, [parfum, eau_de_parfum, eau_de_toillete, eau_de_cologne, eau_fraiche]).
composition(X, CF) :- menuask(composition, X, CF, [amber, aromatic, eastern, floral, woody, fruity, citrus, green, fougere, chypre, aquatic, gourmand]).

season(X, CF) :- ask(season, X, CF).
datetime(X, CF) :- ask(datetime, X, CF).
age_group(X, CF) :- ask(age_group, X, CF).
top_note(X, CF) :- ask(top_note, X, CF).
middle_note(X, CF) :- ask(middle_note, X, CF).
base_note(X, CF) :- ask(base_note, X, CF).

multivalued(season).
multivalued(datetime).
multivalued(top_note).
multivalued(middle_note).
multivalued(base_note).

fragrance(jpg_le_male_elixir, CF) :- 
    season(winter, CF1),
    datetime(night, CF2),
    longevity(long_lasting, CF3),
    sillage(strong, CF4),
    gender(male, CF5),
    price(ok, CF6),
    volume(medium, CF7),
    concentration(eau_de_parfum, CF8),
    composition(fougere, CF9),
    top_note(lavender, CF10), 
    middle_note(vanilla, CF11), 
    base_note(honey, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(givenchy_gentleman, CF) :- 
    season(fall, CF1),
    datetime(night, CF2),
    longevity(long_lasting, CF3),
    sillage(moderate, CF4),
    gender(male, CF5),
    price(ok, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(fougere, CF9),
    top_note(bergamot, CF10), 
    middle_note(iris, CF11), 
    base_note(amber, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(jpg_le_beau, CF) :- 
    season(summer, CF1),
    datetime(day, CF2),
    longevity(long_lasting, CF3),
    sillage(moderate, CF4),
    gender(male, CF5),
    price(ok, CF6),
    volume(big, CF7),
    concentration(eau_de_parfum, CF8),
    composition(woody, CF9),
    top_note(pineapple, CF10), 
    middle_note(coconut, CF11), 
    base_note(sandalwood, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(terre_dhermes, CF) :- 
    season(spring, CF1),
    datetime(day, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(more_male, CF5),
    price(ok, CF6),
    volume(medium, CF7),
    concentration(eau_de_parfum, CF8),
    composition(citrus, CF9),
    top_note(citron, CF10), 
    middle_note(juniper, CF11), 
    base_note(woody, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(azzaro_most_wanted, CF) :- 
    season(fall, CF1),
    datetime(night, CF2),
    longevity(long_lasting, CF3),
    sillage(moderate, CF4),
    gender(male, CF5),
    price(ok, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(woody, CF9),
    top_note(ginger, CF10), 
    middle_note(woody, CF11), 
    base_note(vanilla, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(armani_aqcua_di_gio, CF) :- 
    season(summer, CF1),
    datetime(day, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(male, CF5),
    price(overpriced, CF6),
    volume(medium, CF7),
    concentration(parfum, CF8),
    composition(aquatic, CF9),
    top_note(lavender, CF10), 
    middle_note(vanilla, CF11), 
    base_note(honey, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(ysl_libre_le_parfum, CF) :- 
    season(fall, CF1),
    datetime(night, CF2),
    longevity(long_lasting, CF3),
    sillage(strong, CF4),
    gender(female, CF5),
    price(ok, CF6),
    volume(medium, CF7),
    concentration(eau_de_parfum, CF8),
    composition(floral, CF9),
    top_note(orange, CF10), 
    middle_note(lavender, CF11), 
    base_note(vetiver, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(kilian_angels_share, CF) :- 
    season(winter, CF1),
    datetime(night, CF2),
    longevity(eternal, CF3),
    sillage(enormous, CF4),
    gender(unisex, CF5),
    price(overpriced, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(amber, CF9),
    top_note(cognac, CF10), 
    middle_note(cinnamon, CF11), 
    base_note(praline, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(burberry_goddess, CF) :- 
    season(spring, CF1),
    datetime(day, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(female, CF5),
    price(overpriced, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(aromatic, CF9),
    top_note(lavender, CF10), 
    middle_note(cacao, CF11), 
    base_note(vanilla, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(narcisso_rodriguez_musc_noir_rose, CF) :- 
    season(fall, CF1),
    datetime(night, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(female, CF5),
    price(ok, CF6),
    volume(big, CF7),
    concentration(eau_de_parfum, CF8),
    composition(floral, CF9),
    top_note(plum, CF10), 
    middle_note(rose, CF11), 
    base_note(vanilla, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(dolce_gabbana_devotion, CF) :- 
    season(spring, CF1),
    datetime(day, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(female, CF5),
    price(ok, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(eastern, CF9),
    top_note(lemon, CF10), 
    middle_note(rum, CF11), 
    base_note(vanilla, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

fragrance(ysl_black_opium, CF) :- 
    season(winter, CF1),
    datetime(night, CF2),
    longevity(moderate, CF3),
    sillage(moderate, CF4),
    gender(female, CF5),
    price(ok, CF6),
    volume(small, CF7),
    concentration(eau_de_parfum, CF8),
    composition(eastern, CF9),
    top_note(cinnamon, CF10), 
    middle_note(jasmine, CF11), 
    base_note(vanilla, CF12),
    evaluate_certainty_factors([CF1, CF2, CF3, CF4, CF5, CF6, CF7, CF8, CF8, CF9, CF10, CF11, CF12], CF).

top_goal(X, CF) :- fragrance(X, CF).

evaluate_certainty_factors(ListOfCFs, FinalCF) :-  product_of_cfs(ListOfCFs, 1, FinalCF).
product_of_cfs([], Acc, Acc).
product_of_cfs([CF | Rest], Acc, Result) :- NewAcc is Acc * CF, product_of_cfs(Rest, NewAcc, Result).

longevity(X) :- menuask(longevity, X, [very_weak, weak, moderate, long_lasting, eternal]).
sillage(X) :- menuask(sillage, X, [intimate, moderate, strong, enormous]).
gender(X) :- menuask(gender, X, [female, more_female, unisex, more_male, male]).
price(X) :- menuask(price, X, [way_overpriced, overpriced, ok, good_value, great_value]).
volume(X) :- menuask(volume, X, [small, medium, big]).
concentration(X) :- menuask(concentration, X, [parfum, eau_de_parfum, eau_de_toillete, eau_de_cologne, eau_fraiche]).
composition(X) :- menuask(composition, X, [amber, aromatic, eastern, floral, woody, fruity, citrus, green, fougere, chypre, aquatic, gourmand]).

season(X) :- ask(season, X).
datetime(X) :- ask(datetime, X).
age_group(X) :- ask(age_group, X).
top_note(X) :- ask(top_note, X).
middle_note(X) :- ask(middle_note, X).
base_note(X) :- ask(base_note, X).

multivalued(season).
multivalued(datetime).
multivalued(top_note).
multivalued(middle_note).
multivalued(base_note).

fragrance(jpg_le_male_elixir) :- 
    season(winter),
    datetime(night),
    longevity(long_lasting),
    sillage(strong),
    gender(male),
    price(ok),
    volume(medium),
    concentration(eau_de_parfum),
    composition(fougere),
    top_note(lavender), 
    middle_note(vanilla), 
    base_note(honey).

fragrance(givenchy_gentleman) :- 
    season(fall),
    datetime(night),
    longevity(long_lasting),
    sillage(moderate),
    gender(male),
    price(ok),
    volume(small),
    concentration(eau_de_parfum),
    composition(fougere),
    top_note(bergamot), 
    middle_note(iris), 
    base_note(amber).

fragrance(jpg_le_beau) :- 
    season(summer),
    datetime(day),
    longevity(long_lasting),
    sillage(moderate),
    gender(male),
    price(ok),
    volume(big),
    concentration(eau_de_parfum),
    composition(woody),
    top_note(pineapple), 
    middle_note(coconut), 
    base_note(sandalwood).

fragrance(terre_dhermes) :- 
    season(spring),
    datetime(day),
    longevity(moderate),
    sillage(moderate),
    gender(more_male),
    price(ok),
    volume(medium),
    concentration(eau_de_parfum),
    composition(citrus),
    top_note(citron), 
    middle_note(juniper), 
    base_note(woody).

fragrance(azzaro_most_wanted) :- 
    season(fall),
    datetime(night),
    longevity(long_lasting),
    sillage(moderate),
    gender(male),
    price(ok),
    volume(small),
    concentration(eau_de_parfum),
    composition(woody),
    top_note(ginger), 
    middle_note(woody), 
    base_note(vanilla).

fragrance(armani_aqcua_di_gio) :- 
    season(summer),
    datetime(day),
    longevity(moderate),
    sillage(moderate),
    gender(male),
    price(overpriced),
    volume(medium),
    concentration(parfum),
    composition(aquatic),
    top_note(lavender), 
    middle_note(vanilla), 
    base_note(honey).

fragrance(ysl_libre_le_parfum) :- 
    season(fall),
    datetime(night),
    longevity(long_lasting),
    sillage(strong),
    gender(female),
    price(ok),
    volume(medium),
    concentration(eau_de_parfum),
    composition(floral),
    top_note(orange), 
    middle_note(lavender), 
    base_note(vetiver).

fragrance(kilian_angels_share) :- 
    season(winter),
    datetime(night),
    longevity(eternal),
    sillage(enormous),
    gender(unisex),
    price(overpriced),
    volume(small),
    concentration(eau_de_parfum),
    composition(amber),
    top_note(cognac), 
    middle_note(cinnamon), 
    base_note(praline).

fragrance(burberry_goddess) :- 
    season(spring),
    datetime(day),
    longevity(moderate),
    sillage(moderate),
    gender(female),
    price(overpriced),
    volume(small),
    concentration(eau_de_parfum),
    composition(aromatic),
    top_note(lavender), 
    middle_note(cacao), 
    base_note(vanilla).

fragrance(narcisso_rodriguez_musc_noir_rose) :- 
    season(fall),
    datetime(night),
    longevity(moderate),
    sillage(moderate),
    gender(female),
    price(ok),
    volume(big),
    concentration(eau_de_parfum),
    composition(floral),
    top_note(plum), 
    middle_note(rose), 
    base_note(vanilla).

fragrance(dolce_gabbana_devotion) :- 
    season(spring),
    datetime(day),
    longevity(moderate),
    sillage(moderate),
    gender(female),
    price(ok),
    volume(small),
    concentration(eau_de_parfum),
    composition(eastern),
    top_note(lemon), 
    middle_note(rum), 
    base_note(vanilla).

fragrance(ysl_black_opium) :- 
    season(winter),
    datetime(night),
    longevity(moderate),
    sillage(moderate),
    gender(female),
    price(ok),
    volume(small),
    concentration(eau_de_parfum),
    composition(eastern),
    top_note(cinnamon), 
    middle_note(jasmine), 
    base_note(vanilla).

top_goal(X) :- fragrance(X).

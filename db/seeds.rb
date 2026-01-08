# frozen_string_literal: true

puts "🌱 Seeding database..."

# Créer un utilisateur de test
user = User.find_or_create_by!(email: "jeremy.beaussart@gmail.com") do |u|
  u.password = "aaaaaa"
  u.password_confirmation = "aaaaaa"
end

puts "👤 Utilisateur créé: #{user.email}"

# 50 recettes variées
recipes_data = [
  {
    title: "Poulet rôti aux herbes de Provence",
    ingredients: [
      "1 poulet entier (1,5 kg)",
      "3 cuillères à soupe d'herbes de Provence",
      "4 gousses d'ail",
      "2 citrons",
      "4 cuillères à soupe d'huile d'olive",
      "Sel et poivre",
      "1 kg de pommes de terre"
    ],
    steps: [
      "Préchauffer le four à 200°C.",
      "Mélanger les herbes de Provence avec l'huile d'olive, le sel et le poivre.",
      "Badigeonner le poulet avec ce mélange.",
      "Placer l'ail et un citron coupé à l'intérieur du poulet.",
      "Disposer les pommes de terre autour du poulet.",
      "Enfourner pendant 1h15, en arrosant régulièrement.",
      "Laisser reposer 10 minutes avant de servir."
    ],
    preparation_time: 90,
    is_favorite: true
  },
  {
    title: "Gratin dauphinois",
    ingredients: [
      "1 kg de pommes de terre",
      "50 cl de crème fraîche",
      "25 cl de lait",
      "2 gousses d'ail",
      "Noix de muscade",
      "Sel et poivre",
      "30 g de beurre"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Éplucher et couper les pommes de terre en fines rondelles.",
      "Frotter un plat à gratin avec l'ail et le beurre.",
      "Disposer les pommes de terre en couches.",
      "Mélanger la crème, le lait, sel, poivre et muscade.",
      "Verser sur les pommes de terre.",
      "Enfourner pendant 1h15 jusqu'à ce que le dessus soit doré."
    ],
    preparation_time: 90,
    is_favorite: true
  },
  {
    title: "Quiche lorraine",
    ingredients: [
      "1 pâte brisée",
      "200 g de lardons",
      "4 œufs",
      "25 cl de crème fraîche",
      "15 cl de lait",
      "100 g de gruyère râpé",
      "Sel et poivre",
      "Noix de muscade"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Étaler la pâte dans un moule et piquer le fond.",
      "Faire revenir les lardons à la poêle.",
      "Répartir les lardons sur la pâte.",
      "Battre les œufs avec la crème, le lait et les assaisonnements.",
      "Verser l'appareil et parsemer de gruyère.",
      "Enfourner 35-40 minutes."
    ],
    preparation_time: 55,
    is_favorite: true
  },
  {
    title: "Bœuf bourguignon",
    ingredients: [
      "1 kg de bœuf à braiser",
      "75 cl de vin rouge de Bourgogne",
      "200 g de lardons",
      "200 g de champignons",
      "20 petits oignons",
      "2 carottes",
      "2 cuillères à soupe de farine",
      "Bouquet garni",
      "Sel et poivre"
    ],
    steps: [
      "Couper la viande en gros cubes.",
      "Faire mariner la viande dans le vin avec le bouquet garni une nuit.",
      "Faire revenir les lardons, puis les oignons.",
      "Égoutter et faire dorer la viande.",
      "Saupoudrer de farine et mélanger.",
      "Ajouter le vin de la marinade et les carottes.",
      "Laisser mijoter 2h30 à feu doux.",
      "Ajouter les champignons 30 minutes avant la fin."
    ],
    preparation_time: 180,
    is_favorite: true
  },
  {
    title: "Crêpes sucrées",
    ingredients: [
      "250 g de farine",
      "4 œufs",
      "50 cl de lait",
      "50 g de beurre fondu",
      "2 cuillères à soupe de sucre",
      "1 pincée de sel",
      "1 cuillère à soupe de rhum (optionnel)"
    ],
    steps: [
      "Mettre la farine dans un saladier et former un puits.",
      "Ajouter les œufs battus et mélanger.",
      "Incorporer le lait progressivement.",
      "Ajouter le beurre fondu, le sucre, le sel et le rhum.",
      "Laisser reposer la pâte 1 heure.",
      "Cuire les crêpes dans une poêle chaude beurrée.",
      "Garnir selon vos envies : sucre, Nutella, confiture..."
    ],
    preparation_time: 30,
    is_favorite: true
  },
  {
    title: "Ratatouille",
    ingredients: [
      "2 courgettes",
      "2 aubergines",
      "3 tomates",
      "2 poivrons (rouge et jaune)",
      "2 oignons",
      "4 gousses d'ail",
      "Herbes de Provence",
      "Huile d'olive",
      "Sel et poivre"
    ],
    steps: [
      "Couper tous les légumes en dés.",
      "Faire revenir les oignons dans l'huile d'olive.",
      "Ajouter les poivrons et l'ail, cuire 5 minutes.",
      "Ajouter les aubergines et les courgettes.",
      "Ajouter les tomates et les herbes.",
      "Laisser mijoter 45 minutes à feu doux.",
      "Rectifier l'assaisonnement et servir."
    ],
    preparation_time: 60,
    is_favorite: false
  },
  {
    title: "Tarte aux pommes",
    ingredients: [
      "1 pâte feuilletée",
      "6 pommes Golden",
      "50 g de beurre",
      "80 g de sucre",
      "1 sachet de sucre vanillé",
      "Cannelle (optionnel)"
    ],
    steps: [
      "Préchauffer le four à 200°C.",
      "Étaler la pâte dans un moule.",
      "Éplucher et couper les pommes en fines lamelles.",
      "Disposer les pommes en rosace sur la pâte.",
      "Parsemer de morceaux de beurre et de sucre.",
      "Enfourner 35-40 minutes.",
      "Servir tiède avec une boule de glace vanille."
    ],
    preparation_time: 50,
    is_favorite: true
  },
  {
    title: "Blanquette de veau",
    ingredients: [
      "1 kg d'épaule de veau",
      "2 carottes",
      "2 poireaux",
      "1 oignon piqué de clous de girofle",
      "1 bouquet garni",
      "200 g de champignons",
      "30 cl de crème fraîche",
      "2 jaunes d'œufs",
      "Jus d'un demi citron"
    ],
    steps: [
      "Couper le veau en morceaux.",
      "Les mettre dans une cocotte, couvrir d'eau froide.",
      "Porter à ébullition et écumer.",
      "Ajouter les légumes et le bouquet garni.",
      "Laisser mijoter 1h30.",
      "Préparer la sauce avec la crème et les jaunes.",
      "Napper la viande de sauce et servir avec du riz."
    ],
    preparation_time: 120,
    is_favorite: false
  },
  {
    title: "Lasagnes à la bolognaise",
    ingredients: [
      "500 g de viande hachée",
      "1 boîte de tomates pelées",
      "2 oignons",
      "2 gousses d'ail",
      "Feuilles de lasagne",
      "50 cl de béchamel",
      "150 g de parmesan râpé",
      "Huile d'olive",
      "Sel, poivre, origan"
    ],
    steps: [
      "Faire revenir oignons et ail dans l'huile.",
      "Ajouter la viande et faire dorer.",
      "Ajouter les tomates, assaisonner et mijoter 30 minutes.",
      "Préchauffer le four à 180°C.",
      "Alterner couches de sauce, lasagne et béchamel.",
      "Terminer par la béchamel et le parmesan.",
      "Enfourner 40 minutes."
    ],
    preparation_time: 75,
    is_favorite: true
  },
  {
    title: "Mousse au chocolat",
    ingredients: [
      "200 g de chocolat noir",
      "6 œufs",
      "1 pincée de sel",
      "30 g de sucre (optionnel)"
    ],
    steps: [
      "Faire fondre le chocolat au bain-marie.",
      "Séparer les blancs des jaunes.",
      "Incorporer les jaunes au chocolat fondu.",
      "Monter les blancs en neige ferme avec le sel.",
      "Incorporer délicatement les blancs au chocolat.",
      "Répartir dans des verrines.",
      "Réfrigérer au moins 4 heures."
    ],
    preparation_time: 20,
    is_favorite: true
  },
  {
    title: "Soupe à l'oignon gratinée",
    ingredients: [
      "500 g d'oignons",
      "50 g de beurre",
      "1 litre de bouillon de bœuf",
      "10 cl de vin blanc",
      "8 tranches de pain",
      "150 g de gruyère râpé",
      "Sel et poivre"
    ],
    steps: [
      "Émincer les oignons finement.",
      "Les faire fondre dans le beurre 20 minutes.",
      "Ajouter le vin blanc et laisser réduire.",
      "Verser le bouillon et mijoter 30 minutes.",
      "Verser la soupe dans des bols allant au four.",
      "Déposer le pain et le fromage.",
      "Gratiner sous le grill 5 minutes."
    ],
    preparation_time: 60,
    is_favorite: false
  },
  {
    title: "Pâtes carbonara",
    ingredients: [
      "400 g de spaghetti",
      "200 g de guanciale ou lardons",
      "4 jaunes d'œufs",
      "100 g de pecorino râpé",
      "Poivre noir",
      "Sel"
    ],
    steps: [
      "Cuire les pâtes dans l'eau bouillante salée.",
      "Faire revenir le guanciale sans matière grasse.",
      "Mélanger jaunes d'œufs, pecorino et poivre.",
      "Égoutter les pâtes en gardant un peu d'eau de cuisson.",
      "Mélanger les pâtes chaudes avec le guanciale.",
      "Retirer du feu et ajouter le mélange œufs-fromage.",
      "Mélanger rapidement et servir aussitôt."
    ],
    preparation_time: 25,
    is_favorite: true
  },
  {
    title: "Curry de poulet",
    ingredients: [
      "600 g de blancs de poulet",
      "40 cl de lait de coco",
      "2 oignons",
      "3 gousses d'ail",
      "2 cuillères à soupe de curry",
      "1 cuillère à soupe de curcuma",
      "2 tomates",
      "Huile végétale",
      "Sel"
    ],
    steps: [
      "Couper le poulet en morceaux.",
      "Faire revenir les oignons et l'ail.",
      "Ajouter les épices et mélanger.",
      "Ajouter le poulet et faire dorer.",
      "Incorporer les tomates et le lait de coco.",
      "Laisser mijoter 25 minutes.",
      "Servir avec du riz basmati."
    ],
    preparation_time: 40,
    is_favorite: true
  },
  {
    title: "Salade niçoise",
    ingredients: [
      "200 g de thon en boîte",
      "4 œufs durs",
      "200 g de haricots verts",
      "4 tomates",
      "1 concombre",
      "1 poivron",
      "100 g d'olives noires",
      "8 filets d'anchois",
      "Huile d'olive, vinaigre, sel, poivre"
    ],
    steps: [
      "Cuire les haricots verts et les œufs.",
      "Couper tous les légumes en morceaux.",
      "Disposer les légumes dans un grand plat.",
      "Ajouter le thon émietté et les anchois.",
      "Couper les œufs en quartiers et disposer.",
      "Ajouter les olives.",
      "Assaisonner avec la vinaigrette et servir frais."
    ],
    preparation_time: 30,
    is_favorite: false
  },
  {
    title: "Risotto aux champignons",
    ingredients: [
      "300 g de riz arborio",
      "200 g de champignons de Paris",
      "100 g de champignons séchés",
      "1 oignon",
      "15 cl de vin blanc",
      "1 litre de bouillon de volaille",
      "50 g de parmesan",
      "50 g de beurre"
    ],
    steps: [
      "Réhydrater les champignons séchés.",
      "Faire revenir l'oignon dans le beurre.",
      "Ajouter le riz et nacrer 2 minutes.",
      "Déglacer au vin blanc.",
      "Ajouter le bouillon louche par louche en remuant.",
      "Ajouter les champignons à mi-cuisson.",
      "Terminer avec le parmesan et le beurre."
    ],
    preparation_time: 45,
    is_favorite: false
  },
  {
    title: "Couscous royal",
    ingredients: [
      "500 g de semoule",
      "300 g de poulet",
      "300 g d'agneau",
      "4 merguez",
      "4 carottes",
      "4 navets",
      "2 courgettes",
      "1 boîte de pois chiches",
      "2 cuillères à soupe de ras el hanout",
      "Harissa"
    ],
    steps: [
      "Faire dorer les viandes dans une cocotte.",
      "Ajouter les épices et couvrir d'eau.",
      "Ajouter les légumes selon leur temps de cuisson.",
      "Préparer la semoule selon les instructions.",
      "Griller les merguez à part.",
      "Servir la semoule avec les viandes, légumes et bouillon.",
      "Accompagner de harissa."
    ],
    preparation_time: 90,
    is_favorite: true
  },
  {
    title: "Tiramisu",
    ingredients: [
      "500 g de mascarpone",
      "6 œufs",
      "150 g de sucre",
      "30 biscuits à la cuillère",
      "30 cl de café fort froid",
      "Cacao en poudre",
      "2 cuillères à soupe d'amaretto (optionnel)"
    ],
    steps: [
      "Séparer les blancs des jaunes.",
      "Fouetter les jaunes avec le sucre jusqu'à blanchiment.",
      "Incorporer le mascarpone.",
      "Monter les blancs en neige et incorporer délicatement.",
      "Tremper les biscuits dans le café.",
      "Alterner couches de biscuits et de crème.",
      "Réfrigérer 6h et saupoudrer de cacao avant de servir."
    ],
    preparation_time: 30,
    is_favorite: true
  },
  {
    title: "Poulet basquaise",
    ingredients: [
      "1 poulet découpé",
      "4 poivrons (rouge, vert, jaune)",
      "4 tomates",
      "2 oignons",
      "4 gousses d'ail",
      "200 g de jambon de Bayonne",
      "15 cl de vin blanc",
      "Piment d'Espelette",
      "Huile d'olive"
    ],
    steps: [
      "Faire dorer les morceaux de poulet.",
      "Réserver et faire revenir les oignons.",
      "Ajouter les poivrons en lanières.",
      "Ajouter l'ail, les tomates et le jambon.",
      "Remettre le poulet, ajouter le vin.",
      "Assaisonner avec le piment d'Espelette.",
      "Couvrir et mijoter 45 minutes."
    ],
    preparation_time: 75,
    is_favorite: false
  },
  {
    title: "Gâteau au yaourt",
    ingredients: [
      "1 yaourt nature",
      "3 pots de farine",
      "2 pots de sucre",
      "1/2 pot d'huile",
      "3 œufs",
      "1 sachet de levure",
      "1 sachet de sucre vanillé"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Verser le yaourt dans un saladier (garder le pot).",
      "Ajouter le sucre et mélanger.",
      "Ajouter les œufs un par un.",
      "Incorporer la farine et la levure.",
      "Ajouter l'huile et bien mélanger.",
      "Verser dans un moule beurré et cuire 35 minutes."
    ],
    preparation_time: 45,
    is_favorite: false
  },
  {
    title: "Salade César",
    ingredients: [
      "1 laitue romaine",
      "2 blancs de poulet",
      "100 g de parmesan",
      "100 g de croûtons",
      "4 filets d'anchois",
      "1 jaune d'œuf",
      "1 gousse d'ail",
      "Jus de citron",
      "Huile d'olive",
      "Moutarde"
    ],
    steps: [
      "Griller les blancs de poulet et les trancher.",
      "Préparer la sauce : mixer anchois, ail, jaune d'œuf, moutarde.",
      "Ajouter l'huile en filet et le jus de citron.",
      "Laver et couper la salade.",
      "Mélanger avec la sauce.",
      "Ajouter le poulet, les croûtons.",
      "Parsemer de copeaux de parmesan."
    ],
    preparation_time: 25,
    is_favorite: false
  },
  {
    title: "Chili con carne",
    ingredients: [
      "500 g de bœuf haché",
      "1 boîte de haricots rouges",
      "1 boîte de tomates concassées",
      "2 oignons",
      "2 gousses d'ail",
      "2 cuillères à soupe de cumin",
      "1 cuillère à café de piment",
      "1 poivron rouge",
      "Sel et poivre"
    ],
    steps: [
      "Faire revenir les oignons et l'ail.",
      "Ajouter la viande et faire dorer.",
      "Incorporer les épices.",
      "Ajouter le poivron coupé en dés.",
      "Verser les tomates et les haricots égouttés.",
      "Laisser mijoter 45 minutes.",
      "Servir avec du riz et de la crème fraîche."
    ],
    preparation_time: 60,
    is_favorite: true
  },
  {
    title: "Tarte tatin",
    ingredients: [
      "1 pâte feuilletée",
      "8 pommes Golden",
      "150 g de sucre",
      "100 g de beurre",
      "1 cuillère à café de cannelle"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Faire un caramel avec le sucre et le beurre.",
      "Verser dans un moule à manqué.",
      "Disposer les pommes coupées en quartiers.",
      "Saupoudrer de cannelle.",
      "Recouvrir de pâte en rentrant les bords.",
      "Cuire 40 minutes et retourner à la sortie du four."
    ],
    preparation_time: 55,
    is_favorite: true
  },
  {
    title: "Pot-au-feu",
    ingredients: [
      "800 g de bœuf (gîte, plat de côte)",
      "4 poireaux",
      "4 carottes",
      "4 navets",
      "2 oignons",
      "1 céleri branche",
      "1 bouquet garni",
      "Gros sel",
      "Cornichons et moutarde pour servir"
    ],
    steps: [
      "Mettre la viande dans une grande marmite d'eau froide.",
      "Porter à ébullition et écumer.",
      "Ajouter le bouquet garni et les oignons.",
      "Cuire 2h à petits frémissements.",
      "Ajouter les légumes selon leur temps de cuisson.",
      "Poursuivre la cuisson 1h.",
      "Servir avec le bouillon, gros sel, cornichons et moutarde."
    ],
    preparation_time: 180,
    is_favorite: false
  },
  {
    title: "Pizza margherita",
    ingredients: [
      "500 g de farine",
      "1 sachet de levure de boulanger",
      "30 cl d'eau tiède",
      "1 cuillère à café de sel",
      "2 cuillères à soupe d'huile d'olive",
      "400 g de sauce tomate",
      "250 g de mozzarella",
      "Basilic frais"
    ],
    steps: [
      "Mélanger farine, levure, sel, eau et huile.",
      "Pétrir 10 minutes et laisser lever 1h.",
      "Préchauffer le four à 250°C.",
      "Étaler la pâte et garnir de sauce tomate.",
      "Ajouter la mozzarella en morceaux.",
      "Enfourner 12-15 minutes.",
      "Parsemer de basilic frais à la sortie du four."
    ],
    preparation_time: 90,
    is_favorite: true
  },
  {
    title: "Croque-monsieur",
    ingredients: [
      "8 tranches de pain de mie",
      "4 tranches de jambon blanc",
      "200 g de gruyère râpé",
      "30 cl de béchamel",
      "Beurre"
    ],
    steps: [
      "Préchauffer le four à 200°C.",
      "Beurrer les tranches de pain.",
      "Étaler de la béchamel sur 4 tranches.",
      "Ajouter le jambon et du gruyère.",
      "Recouvrir des autres tranches.",
      "Napper de béchamel et de gruyère.",
      "Enfourner 15 minutes jusqu'à gratination."
    ],
    preparation_time: 25,
    is_favorite: false
  },
  {
    title: "Fondant au chocolat",
    ingredients: [
      "200 g de chocolat noir",
      "150 g de beurre",
      "150 g de sucre",
      "4 œufs",
      "50 g de farine",
      "1 pincée de sel"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Faire fondre le chocolat avec le beurre.",
      "Battre les œufs avec le sucre.",
      "Incorporer le chocolat fondu.",
      "Ajouter la farine et le sel.",
      "Verser dans un moule beurré.",
      "Cuire 20-25 minutes (le centre doit rester coulant)."
    ],
    preparation_time: 35,
    is_favorite: true
  },
  {
    title: "Soupe de légumes",
    ingredients: [
      "3 carottes",
      "2 poireaux",
      "2 pommes de terre",
      "1 oignon",
      "1 navet",
      "1 branche de céleri",
      "1 cube de bouillon",
      "Sel et poivre",
      "Crème fraîche"
    ],
    steps: [
      "Éplucher et couper tous les légumes en morceaux.",
      "Faire revenir l'oignon dans une cocotte.",
      "Ajouter tous les légumes.",
      "Couvrir d'eau et ajouter le bouillon.",
      "Cuire 30-40 minutes.",
      "Mixer selon la consistance souhaitée.",
      "Servir avec une cuillère de crème fraîche."
    ],
    preparation_time: 45,
    is_favorite: false
  },
  {
    title: "Œufs cocotte",
    ingredients: [
      "4 œufs",
      "10 cl de crème fraîche",
      "50 g de comté râpé",
      "4 tranches de jambon",
      "Ciboulette",
      "Sel et poivre",
      "Beurre"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Beurrer 4 ramequins.",
      "Déposer le jambon émincé au fond.",
      "Casser un œuf dans chaque ramequin.",
      "Ajouter la crème et le fromage.",
      "Cuire au bain-marie 12-15 minutes.",
      "Parsemer de ciboulette et servir."
    ],
    preparation_time: 20,
    is_favorite: false
  },
  {
    title: "Tartiflette",
    ingredients: [
      "1 kg de pommes de terre",
      "1 reblochon entier",
      "200 g de lardons",
      "2 oignons",
      "20 cl de crème fraîche",
      "15 cl de vin blanc",
      "Sel et poivre"
    ],
    steps: [
      "Cuire les pommes de terre à l'eau.",
      "Faire revenir les lardons et les oignons.",
      "Déglacer au vin blanc.",
      "Couper les pommes de terre en rondelles.",
      "Mélanger le tout avec la crème dans un plat.",
      "Couper le reblochon en deux et poser dessus.",
      "Gratiner au four 25 minutes à 200°C."
    ],
    preparation_time: 50,
    is_favorite: true
  },
  {
    title: "Saumon en papillote",
    ingredients: [
      "4 pavés de saumon",
      "2 citrons",
      "1 fenouil",
      "4 tomates cerises",
      "Aneth frais",
      "Huile d'olive",
      "Sel et poivre"
    ],
    steps: [
      "Préchauffer le four à 200°C.",
      "Couper 4 feuilles de papier sulfurisé.",
      "Émincer finement le fenouil.",
      "Disposer le fenouil et le saumon sur chaque feuille.",
      "Ajouter rondelles de citron, tomates et aneth.",
      "Arroser d'huile, saler et poivrer.",
      "Fermer les papillotes et cuire 20 minutes."
    ],
    preparation_time: 30,
    is_favorite: false
  },
  {
    title: "Gratin de courgettes",
    ingredients: [
      "4 courgettes",
      "3 œufs",
      "20 cl de crème fraîche",
      "100 g de gruyère râpé",
      "1 oignon",
      "2 gousses d'ail",
      "Huile d'olive",
      "Sel et poivre"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Couper les courgettes en rondelles.",
      "Faire revenir l'oignon et l'ail.",
      "Ajouter les courgettes et cuire 10 minutes.",
      "Battre les œufs avec la crème.",
      "Verser le tout dans un plat, mélanger.",
      "Parsemer de gruyère et gratiner 30 minutes."
    ],
    preparation_time: 50,
    is_favorite: false
  },
  {
    title: "Wok de légumes au tofu",
    ingredients: [
      "400 g de tofu ferme",
      "2 carottes",
      "1 poivron",
      "200 g de brocoli",
      "200 g de pousses de soja",
      "3 cuillères à soupe de sauce soja",
      "1 cuillère à soupe de miel",
      "2 gousses d'ail",
      "Gingembre frais",
      "Huile de sésame"
    ],
    steps: [
      "Couper le tofu en cubes et le faire dorer.",
      "Réserver et faire sauter les légumes.",
      "Ajouter l'ail et le gingembre râpé.",
      "Remettre le tofu.",
      "Mélanger sauce soja, miel et huile de sésame.",
      "Verser sur le wok et mélanger.",
      "Servir avec du riz ou des nouilles."
    ],
    preparation_time: 30,
    is_favorite: false
  },
  {
    title: "Clafoutis aux cerises",
    ingredients: [
      "500 g de cerises",
      "4 œufs",
      "100 g de sucre",
      "100 g de farine",
      "25 cl de lait",
      "1 sachet de sucre vanillé",
      "Beurre pour le moule"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Beurrer un plat à gratin.",
      "Laver et équeuter les cerises (garder les noyaux).",
      "Battre les œufs avec le sucre.",
      "Incorporer la farine puis le lait.",
      "Répartir les cerises et verser l'appareil.",
      "Cuire 40 minutes et servir tiède."
    ],
    preparation_time: 55,
    is_favorite: false
  },
  {
    title: "Poulet au citron",
    ingredients: [
      "4 cuisses de poulet",
      "2 citrons (jus et zestes)",
      "4 gousses d'ail",
      "2 cuillères à soupe de miel",
      "Thym frais",
      "Huile d'olive",
      "Sel et poivre"
    ],
    steps: [
      "Préchauffer le four à 200°C.",
      "Mélanger jus de citron, miel, ail écrasé et thym.",
      "Disposer le poulet dans un plat.",
      "Verser la marinade et ajouter les zestes.",
      "Arroser d'huile d'olive.",
      "Enfourner 45 minutes en arrosant régulièrement.",
      "Servir avec le jus de cuisson."
    ],
    preparation_time: 55,
    is_favorite: false
  },
  {
    title: "Panna cotta",
    ingredients: [
      "50 cl de crème liquide",
      "80 g de sucre",
      "1 gousse de vanille",
      "3 feuilles de gélatine",
      "Coulis de fruits rouges"
    ],
    steps: [
      "Faire ramollir la gélatine dans l'eau froide.",
      "Chauffer la crème avec le sucre et la vanille fendue.",
      "Retirer du feu, ôter la gousse.",
      "Incorporer la gélatine essorée.",
      "Répartir dans des verrines.",
      "Réfrigérer au moins 4 heures.",
      "Servir avec le coulis de fruits rouges."
    ],
    preparation_time: 20,
    is_favorite: false
  },
  {
    title: "Burger maison",
    ingredients: [
      "4 pains à burger",
      "600 g de bœuf haché",
      "4 tranches de cheddar",
      "4 feuilles de salade",
      "2 tomates",
      "1 oignon rouge",
      "Cornichons",
      "Ketchup, moutarde, mayonnaise"
    ],
    steps: [
      "Former 4 steaks avec la viande, saler et poivrer.",
      "Cuire les steaks selon votre préférence.",
      "Ajouter le cheddar en fin de cuisson.",
      "Toaster les pains légèrement.",
      "Tartiner les sauces sur les pains.",
      "Monter le burger : salade, tomate, steak, oignon.",
      "Ajouter les cornichons et refermer."
    ],
    preparation_time: 25,
    is_favorite: true
  },
  {
    title: "Velouté de potiron",
    ingredients: [
      "1 kg de potiron",
      "2 pommes de terre",
      "1 oignon",
      "1 litre de bouillon de légumes",
      "20 cl de crème fraîche",
      "Noix de muscade",
      "Sel et poivre"
    ],
    steps: [
      "Couper le potiron et les pommes de terre en morceaux.",
      "Faire revenir l'oignon.",
      "Ajouter les légumes et le bouillon.",
      "Cuire 30 minutes à couvert.",
      "Mixer finement.",
      "Ajouter la crème et la muscade.",
      "Servir avec des croûtons."
    ],
    preparation_time: 45,
    is_favorite: false
  },
  {
    title: "Pavé de bœuf sauce au poivre",
    ingredients: [
      "4 pavés de bœuf",
      "20 cl de crème fraîche",
      "2 cuillères à soupe de poivre vert",
      "3 cl de cognac",
      "2 échalotes",
      "30 g de beurre",
      "Sel"
    ],
    steps: [
      "Cuire les pavés dans le beurre selon votre goût.",
      "Réserver au chaud.",
      "Faire revenir les échalotes émincées.",
      "Déglacer au cognac (flamber si désiré).",
      "Ajouter le poivre vert et la crème.",
      "Laisser réduire 5 minutes.",
      "Napper les pavés de sauce et servir."
    ],
    preparation_time: 25,
    is_favorite: true
  },
  {
    title: "Tarte au citron meringuée",
    ingredients: [
      "1 pâte sablée",
      "4 citrons (jus et zestes)",
      "200 g de sucre",
      "4 œufs",
      "100 g de beurre",
      "3 blancs d'œufs",
      "150 g de sucre glace"
    ],
    steps: [
      "Cuire la pâte à blanc 15 minutes à 180°C.",
      "Chauffer jus de citron, zestes, sucre et œufs au bain-marie.",
      "Incorporer le beurre et cuire jusqu'à épaississement.",
      "Verser la crème sur le fond de tarte.",
      "Monter les blancs en neige avec le sucre glace.",
      "Déposer la meringue sur la tarte.",
      "Dorer au four 5 minutes."
    ],
    preparation_time: 60,
    is_favorite: true
  },
  {
    title: "Boulettes de viande à la tomate",
    ingredients: [
      "500 g de viande hachée",
      "1 œuf",
      "50 g de chapelure",
      "1 oignon",
      "500 ml de sauce tomate",
      "2 gousses d'ail",
      "Basilic frais",
      "Parmesan",
      "Sel et poivre"
    ],
    steps: [
      "Mélanger viande, œuf, chapelure, oignon haché.",
      "Former des boulettes de la taille d'une noix.",
      "Les faire dorer dans une poêle.",
      "Préparer la sauce tomate avec l'ail.",
      "Ajouter les boulettes à la sauce.",
      "Mijoter 20 minutes.",
      "Servir avec du basilic et du parmesan."
    ],
    preparation_time: 40,
    is_favorite: false
  },
  {
    title: "Salade de quinoa",
    ingredients: [
      "200 g de quinoa",
      "1 concombre",
      "200 g de tomates cerises",
      "1 avocat",
      "100 g de feta",
      "Menthe fraîche",
      "Jus de 2 citrons",
      "Huile d'olive",
      "Sel et poivre"
    ],
    steps: [
      "Cuire le quinoa et le laisser refroidir.",
      "Couper le concombre et les tomates.",
      "Couper l'avocat en dés.",
      "Émietter la feta.",
      "Mélanger tous les ingrédients.",
      "Préparer la vinaigrette citron-huile.",
      "Assaisonner et parsemer de menthe."
    ],
    preparation_time: 25,
    is_favorite: false
  },
  {
    title: "Porc au caramel",
    ingredients: [
      "600 g de poitrine de porc",
      "100 g de sucre",
      "4 cuillères à soupe de nuoc-mam",
      "3 gousses d'ail",
      "1 oignon",
      "Poivre",
      "Coriandre fraîche"
    ],
    steps: [
      "Couper le porc en morceaux.",
      "Faire un caramel à sec avec le sucre.",
      "Ajouter le nuoc-mam (attention aux projections).",
      "Faire dorer le porc.",
      "Ajouter l'ail, l'oignon et couvrir d'eau.",
      "Mijoter 1h à feu doux.",
      "Servir avec du riz et de la coriandre."
    ],
    preparation_time: 75,
    is_favorite: false
  },
  {
    title: "Gaspacho",
    ingredients: [
      "1 kg de tomates bien mûres",
      "1 concombre",
      "1 poivron rouge",
      "2 gousses d'ail",
      "3 cuillères à soupe d'huile d'olive",
      "2 cuillères à soupe de vinaigre de Xérès",
      "Sel et poivre",
      "Basilic"
    ],
    steps: [
      "Épépiner et couper les tomates.",
      "Peler le concombre et le poivron.",
      "Mixer tous les légumes avec l'ail.",
      "Ajouter l'huile et le vinaigre.",
      "Assaisonner et mixer à nouveau.",
      "Réfrigérer au moins 2 heures.",
      "Servir très frais avec des croûtons."
    ],
    preparation_time: 20,
    is_favorite: false
  },
  {
    title: "Canard à l'orange",
    ingredients: [
      "4 magrets de canard",
      "4 oranges",
      "2 cuillères à soupe de miel",
      "10 cl de Grand Marnier",
      "20 cl de fond de veau",
      "Sel et poivre"
    ],
    steps: [
      "Quadriller la peau des magrets.",
      "Les cuire côté peau 10 minutes, puis 5 minutes côté chair.",
      "Réserver au chaud.",
      "Déglacer la poêle avec le jus de 2 oranges.",
      "Ajouter le miel, le Grand Marnier et le fond.",
      "Réduire de moitié.",
      "Trancher les magrets et napper de sauce."
    ],
    preparation_time: 35,
    is_favorite: true
  },
  {
    title: "Crumble aux pommes",
    ingredients: [
      "6 pommes",
      "150 g de farine",
      "100 g de beurre froid",
      "100 g de sucre roux",
      "50 g de poudre d'amande",
      "Cannelle"
    ],
    steps: [
      "Préchauffer le four à 180°C.",
      "Éplucher et couper les pommes en morceaux.",
      "Les disposer dans un plat avec la cannelle.",
      "Mélanger du bout des doigts farine, beurre, sucre et amande.",
      "Obtenir une texture sableuse.",
      "Répartir sur les pommes.",
      "Cuire 40 minutes jusqu'à dorure."
    ],
    preparation_time: 50,
    is_favorite: false
  },
  {
    title: "Omelette aux fines herbes",
    ingredients: [
      "6 œufs",
      "2 cuillères à soupe de crème",
      "Ciboulette",
      "Persil",
      "Cerfeuil",
      "Estragon",
      "30 g de beurre",
      "Sel et poivre"
    ],
    steps: [
      "Battre les œufs avec la crème.",
      "Ciseler finement toutes les herbes.",
      "Les ajouter aux œufs battus.",
      "Saler et poivrer.",
      "Faire fondre le beurre dans une poêle.",
      "Verser les œufs et cuire en remuant.",
      "Replier l'omelette et servir baveuse."
    ],
    preparation_time: 10,
    is_favorite: false
  },
  {
    title: "Gratin de pâtes au jambon",
    ingredients: [
      "400 g de pennes",
      "200 g de jambon blanc",
      "50 cl de béchamel",
      "150 g de gruyère râpé",
      "1 cuillère à soupe de moutarde",
      "Sel et poivre"
    ],
    steps: [
      "Cuire les pâtes al dente.",
      "Couper le jambon en dés.",
      "Mélanger la béchamel avec la moutarde.",
      "Mélanger pâtes, jambon et béchamel.",
      "Verser dans un plat à gratin.",
      "Parsemer de gruyère.",
      "Gratiner 20 minutes à 200°C."
    ],
    preparation_time: 40,
    is_favorite: false
  }
]

puts "📖 Création des #{recipes_data.length} recettes..."

recipes_data.each_with_index do |recipe_data, index|
  recipe = user.recipes.find_or_create_by!(title: recipe_data[:title]) do |r|
    r.ingredients = recipe_data[:ingredients]
    r.steps = recipe_data[:steps]
    r.preparation_time = recipe_data[:preparation_time]
    r.is_favorite = recipe_data[:is_favorite]
  end
  print "." if (index + 1) % 10 == 0
end

puts ""
puts "✅ #{user.recipes.count} recettes créées !"
puts ""
puts "🎉 Seeding terminé !"
puts ""
puts "📧 Connexion : famille@example.com"
puts "🔑 Mot de passe : password123"

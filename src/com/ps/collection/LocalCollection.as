package com.ps.collection
{
import com.ps.cards.*;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudeCondition;
import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.sale.CardSale;
import com.ps.cards.sale.CardSaleLevel;
import com.ps.field.controller.CardController;

/**
	 * ...
	 * @author 
	 */
	public class LocalCollection 
	{
		private static var instance:LocalCollection;
		
		public function LocalCollection() 
		{
			
		}
		
		public static function getInstance () :LocalCollection {
			if (instance == null) {
				instance = new LocalCollection ();
			}
			return instance;
		}
		
		public function simulateCollection () :void {
			
			var eptitude:CardEptitude;
            var eptitude2:CardEptitude;
            var eptitude3:CardEptitude;
            var eptitude4:CardEptitude;
            var eptitude5:CardEptitude;
            var eptitude6:CardEptitude;

			var cardData:CardData;
            var cardSale:CardSale
			
			/*
			eptitude = new CardEptitude (CardEptitude.PROVOCATION);
			provocationEptitude.setLevel (EptitudeLevel.SELF);
			provocationEptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			*/

            // TODO спрайт для двойной аттаки
            // TODO раса в описании карты
			
			// #1 мана
			
			// Огонек (1, 1) +
			cardData = new CardData (1, 1, 0);
			cardData.setTitle ('Огонек');
			cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 0, 0, 0);
						
			// Бранящийся сержант (2, 1) +
			// +2 к аттаке до конца хода
			eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
			eptitude.setLevel (EptitudeLevel.SELECTED_ASSOCIATE_UNIT);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			eptitude.setPower (2);
            eptitude.setLifecycle(1);
			cardData = new CardData (2, 1, 1, [eptitude]);
			cardData.setTitle ('Бранящийся сержант');
			cardData.setDescription ('+2 к аттаке до конца хода');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 1, 0, 0);
						
			// Вепрь камнеклык (зверь) (1,1) +
			// рывок
			eptitude = new CardEptitude (CardEptitude.JERK);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			cardData = new CardData (1, 1, 1, [eptitude]);
			cardData.setTitle ('Вепрь камнеклык');
			cardData.setDescription ('Рывок');
            cardData.setRace(1);
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 2, 1, 0);
			
			// Берсек разведчик (2, 1) +
			// маскировка
			eptitude = new CardEptitude (CardEptitude.SHADOW);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			cardData = new CardData (2, 1, 1, [eptitude]);
			cardData.setTitle ('Берсек разведчик');
			cardData.setDescription ('Маскировка');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 3, 0, 0);

			// Голодный краб (1, 2) +
			// Уничтожает выбранного мурлока и получает +2/+2
            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.SELECTED_ANY_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setRace(2);
            eptitude.marker = true;
            eptitude2 = new CardEptitude(CardEptitude.INCREASE_HEALTH)
            eptitude2.setLevel(EptitudeLevel.SELF)
            eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude2.dependency = CardEptitude.KILL;
            eptitude2.setPower(2);
            eptitude3 = new CardEptitude(CardEptitude.INCREASE_ATTACK)
            eptitude3.setLevel(EptitudeLevel.SELF)
            eptitude3.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude3.dependency = CardEptitude.KILL;
            eptitude3.setPower(2);
            cardData = new CardData (1, 2, 1, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Голодный краб');
            cardData.setDescription ('Уничтожает выбранного мурлока и получает +2/+2');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 4, 0, 0);
			
			// Злая курица (1,1) +
			// Иступление. +5 к аттаке
			eptitude = new CardEptitude (CardEptitude.CHANGE_ATTACK_TILL);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_WOUND);
			eptitude.setPower (5);
			cardData = new CardData (1, 1, 1, [eptitude]);
			cardData.setTitle ('Злая курица');
			cardData.setDescription ('Иступление. +5 к аттаке');
            cardData.setRace(1)
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 5, 1, 0);
			
			// Знахарь вуду (2, 1) +
			// Боевой клич. восстанавливает две единицы здоровья
			eptitude = new CardEptitude (CardEptitude.TREATMENT);
			eptitude.setLevel (EptitudeLevel.SELECTED_ANY);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			eptitude.setPower (2);
			cardData = new CardData (2, 1, 1, [eptitude]);
			cardData.setTitle ('Знахарь вуду');
			cardData.setDescription ('Боевой клич. восстанавливает две единицы здоровья');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 6, 0, 0);
						
			// Лепрогном (2, 1) +
			// Предсмертный хрип. Наносит две единицы урона герою противника
			eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
			eptitude.setLevel (EptitudeLevel.OPPONENT_HERO);
			eptitude.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude.setPower(2);
			cardData = new CardData (2, 1, 1, [eptitude]);
			cardData.setTitle ('Лепрогном');
			cardData.setDescription ('Предсмертный хрип. Наносит две единицы урона герою противника');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 7, 0, 0);
			
			// Молодая жрица (2,1) +
			// В конце хода другое ваше существо получает +1 к здоровью
            eptitude = new CardEptitude (CardEptitude.INCREASE_HEALTH);
			eptitude.setLevel (EptitudeLevel.RANDOM_ASSOCIATE_UNIT);
			eptitude.setPeriod (EptitudePeriod.END_STEP);
			eptitude.setPower (1);
			cardData = new CardData (2, 1, 1, [eptitude]);
			cardData.setTitle ('Молодая жрица');
			cardData.setDescription ('В конце хода другое ваше существо получает +1 к здоровью');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 8, 0, 0);
			
			// Молодой дракондор (1,1) +
			// неистовство ветра
			eptitude = new CardEptitude (CardEptitude.DOUBLE_ATTACK);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			cardData = new CardData (1, 1, 1, [eptitude]);
			cardData.setTitle ('Молодой дракондор');
			cardData.setDescription ('Неистовство ветра');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 9, 0, 0);
			

			// Мурлок волномут (мурлок) (1,2) +
			// каждый раз когда на поле призывается мурлок получает +1 к аттаке
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ALL_RACE_PLACED);
            eptitude.setPower (1);
            eptitude.setRace(2);
            cardData = new CardData (1, 2, 1, [eptitude]);
            cardData.setTitle ('Мурлок волномут');
            cardData.setDescription ('каждый раз когда на поле призывается мурлок получает +1 к аттаке');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 10, 2, 0);
			
			// Мурлок налетчик (мурлок) (2,1) +
			cardData = new CardData (2, 1, 1);
			cardData.setTitle ('Мурлок налетчик');
			cardData.setDescription ('');
			cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 11, 2, 0);
			
			
		    // Оракул темной чешуи (мурлок) (1,1)
			// все прочие мурлоки получают +1 к аттаке
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            eptitude.setRace(2);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (1);
            eptitude2.setRace(2);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (1);
            eptitude3.setRace(2);
            cardData = new CardData (1, 1, 1, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Оракул темной чешуи');
            cardData.setDescription ('все прочие мурлоки получают +1 к аттаке');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 12, 2, 0);
			
			// Сквайр Авангарда (1,1) +
			// Божественнный щит
            eptitude = new CardEptitude (CardEptitude.SHIELD);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (1, 1, 1, [eptitude]);
            cardData.setTitle ('Сквайр Авангарда');
            cardData.setDescription ('Божественный щит');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 13, 0, 0);

            // Солдат златоземья (1,2) +
			// Провокация
			eptitude = new CardEptitude (CardEptitude.PROVOCATION);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			cardData = new CardData (1, 2, 1, [eptitude]);
			cardData.setTitle ('Солдат златоземья');
			cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
			CardsCache.getInstance().addCard (cardData, 14, 0, 0);
			

			// Стражница света (1,2) +
			// каждый раз когда персонаж восстанавливает здоровье стражница света получает +2 к аттаке
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_TREATED);
            eptitude.setPower (2);
            cardData = new CardData (1, 2, 1, [eptitude]);
            cardData.setTitle ('Стражница света');
            cardData.setDescription ('каждый раз когда союзник восстанавливает здоровье стражница света получает +2 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 15, 0, 0);
			
			// Хранительница тайн (1,2)
			// каждый раз когда разыгрывается сектрет это существо получает +1/+1
			
			// Щитоносец (0,4)
			// провокация 
			eptitude = new CardEptitude (CardEptitude.PROVOCATION);
			eptitude.setLevel (EptitudeLevel.SELF);
			eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
			cardData = new CardData (0, 4, 1, [eptitude]);
			cardData.setTitle ('Щитоносец');
			cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 16, 0, 0);
			
			// Эльфийская лучница (1,1) +
			// Боевой клич. наносит 1 единицу урона
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELECTED_OPPONENT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            cardData = new CardData (1, 1, 1, [eptitude]);
            cardData.setTitle ('Эльфийская лучница');
            cardData.setDescription ('Боевой клич. наносит 1 единицу урона');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 17, 0, 0);
			
			// #2 маны
			
			// Амарийский берсек (2,3)
			// Иступление +3 к аттаке
            eptitude = new CardEptitude (CardEptitude.CHANGE_ATTACK_TILL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_WOUND);
            eptitude.setPower (5);
            cardData = new CardData (2, 3, 2, [eptitude]);
            cardData.setTitle ('Амарийский берсек');
            cardData.setDescription ('2');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 18, 0, 0);

			// безумный алхимик (2,2)
			// меняет местами здоровье и аттаку у выбранного существа
            eptitude = new CardEptitude (CardEptitude.REPLACE_ATTACK_HEALTH);
            eptitude.setLevel (EptitudeLevel.SELECTED_ANY_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 2, 2, [eptitude]);
            cardData.setTitle ('Безумный алхимик');
            cardData.setDescription ('Меняет естами здоровье и аттаку выбранного существа');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 19, 0, 0);

            // Боец северного волка (2,2)
			// Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 2, 2, [eptitude]);
            cardData.setTitle ('Боец северного волка');
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 20, 0, 0);
			
			// Вестник рока (0,7)
			// в начале вашего хода уничтожает всех существ
            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.EXTRA_ALL_UNITS);
            eptitude.setPeriod (EptitudePeriod.START_STEP);
            cardData = new CardData (0, 7, 2, [eptitude]);
            cardData.setTitle ('Вестник рока');
            cardData.setDescription ('в начале вашего хода уничтожает всех существ');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 21, 0, 0);

            // TODO: Очень сложный юнит, не знаю пока как его делать
            // возможно нужны ссылки на юниты которых он форматирует + обвес к аттаке
			// Вожак лютых волков (2,2)
			// находящиеся по обестороны существа получают +1 к аттаке
			
			// Воин синежабрых (мурлок) (2,1)
			// рывок
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 1, 2, [eptitude]);
            cardData.setTitle ('Воин синежабрых');
            cardData.setDescription ('Рывок');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 23, 0, 0);

			// Гном призыватель (2,2)
			// первое существо которое вы разыгрываете а каждом шагу стоит на две маны меньше
            eptitude = new CardEptitude (CardEptitude.CARD_SALE);
            cardSale = new CardSale(CardSale.UNIT_CARD, false, 1, 2);
            eptitude.setSale(cardSale)
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel(EptitudeLevel.SELF)
            eptitude.setPeriod(EptitudePeriod.START_STEP)
            cardData = new CardData (2, 2, 2, [eptitude]);
            cardData.setTitle ('Гном призыватель');
            cardData.setDescription ('Первое существо, которое вы разыгрываете а каждом шагу стоит на две маны меньше');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 24, 0, 0);
			
			// Древний дозорный (4,5)
			// не может аттаковать
            eptitude = new CardEptitude (CardEptitude.CAN_NOT_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 5, 2, [eptitude]);
            cardData.setTitle ('Древний дозорный');
            cardData.setDescription ('Не может аттаковть');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 25, 0, 0);

            // Железноклюв (зверь) (2,1)
			// Боевой клич. Накладывает эффект немоты на выбранное существо
            eptitude = new CardEptitude (CardEptitude.DUMBNESS);
            eptitude.setLevel (EptitudeLevel.SELECTED_ANY_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 1, 2, [eptitude]);
            cardData.setTitle ('Железноклюв');
            cardData.setDescription ('Боевой клич. Накладывает эффект немоты на выбранное существо');
            cardData.setRace(1);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 26, 0, 0);
			
			// Жонглер кинжалами (3,2)
			// после того как пизвали на поле бое существо, наносит одну единицу урона случайному персонажу противника
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.RANDOM_OPPONENT);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_PLACED);
            eptitude.setPower (1);
            cardData = new CardData (2, 3, 2, [eptitude]);
            cardData.setTitle ('Жонглер кинжалами');
            cardData.setDescription ('После того как пизвали на поле бое существо, наносит одну единицу урона случайному персонажeу противника.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 27, 0, 0);

			// Застнупница синдорай (2,3)
			// Находящиеся по обе стороны существа получают способность божественный щит.
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 3, 2, [eptitude]);
            cardData.setTitle ('Заступница Синдорай');
            cardData.setDescription ('Находящиеся по обе стороны существа получают способность божественный щит.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 28, 0, 0);

			// инженер новичек (1,1)
			// Боевой клич. Вы берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (1, 1, 2, [eptitude]);
            cardData.setTitle ('Инжкнер новичек');
            cardData.setDescription ('Боевой клич. Вы берете карту.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 29, 0, 0);

			// Кобольт геомант (2,2)
			// Урон от заклинаний +1
            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPower(1);
            cardData = new CardData (2, 2, 2, [eptitude]);
            cardData.setTitle ('Кобольт геомант');
            cardData.setDescription ('Урон от заклинаний +1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 30, 0, 0);

            // Чудесный дрокончик (3,2)
            // Не может быть целью заклинаний и силы героя.
            eptitude = new CardEptitude (CardEptitude.SPELL_INVISIBLE);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 2, 2, [eptitude]);
            cardData.setTitle ('Чудесный дрокончик');
            cardData.setDescription ('Не может быть целью заклинаний и силы героя');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 31, 0, 0);

            // Любительница маны
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_SPELL);
            eptitude.setPower (2);
            eptitude.setLifecycle(1);
            cardData = new CardData (1, 3, 2, [eptitude]);
            cardData.setTitle ('Любительница маны');
            cardData.setDescription ('Каждый раз когда вы разыгрываете заклинание. Получает +2 к аттаке до конца хода.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 32, 0, 0);

			// Мастер ковки клинков (1,3)
			// В конце хода. Другое ваше случайное существо получает +1 к аттаке.
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.RANDOM_ASSOCIATE_UNIT);
            eptitude.setPeriod (EptitudePeriod.END_STEP);
            eptitude.setPower (1);
            cardData = new CardData (1, 3, 2, [eptitude]);
            cardData.setTitle ('Мастер ковки клинков');
            cardData.setDescription ('В конце хода. Другое ваше случайное существо получает +1 к аттаке.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 33, 0, 0);
			
			// Молодой хмелевар (3,2)
			// Возвращает ваше выбранное существо с поля боя в руку
            eptitude = new CardEptitude (CardEptitude.BACK_CARD_TO_HAND);
            eptitude.setLevel (EptitudeLevel.SELECTED_ASSOCIATE_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 2, 2, [eptitude]);
            cardData.setTitle ('Молодой хмелевар');
            cardData.setDescription ('Возвращает ваше выбранное существо с поля боя в руку.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 34, 0, 0);
			
			// Мурлок волнолов (мурлок) (2,1)
			// Боевой клич. Призывает на поле боя мурлока разведчика +1/+1
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setUnitId(36);
            cardData = new CardData (2, 1, 2, [eptitude]);
            cardData.setTitle ('Мурлок волнолов');
            cardData.setDescription ('Боевой клич. Призывает на поле боя мурлока разведчика +1/+1');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            CardsCache.getInstance().addCard (cardData, 35, 2, 0);

            cardData = new CardData (1, 1, 0);
            cardData.setTitle ('Мурлок разведчик');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 36, 2, 0);

			// Нат Пегл (0,4)
			// В начале вашего хода вы с вероятностью 50% берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setProbability(50);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.START_STEP);
            cardData = new CardData (0, 4, 2, [eptitude]);
            cardData.setTitle ('Нат Пегл');
            cardData.setDescription ('В начале вашего хода вы с вероятностью 50% берете карту');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 37, 0, 0);
			
			// Речной кроколикс (зверь) (2,3)
            cardData = new CardData (2, 3, 2);
            cardData.setTitle ('Речной кроколикс');
            cardData.setDescription('');
            cardData.setRace(1);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 38, 0, 0);
			
			// Собиратель сокровищ (2,1)
			// Предсмертный хрип. Вы берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_DIE);
            cardData = new CardData (2, 1, 2, [eptitude]);
            cardData.setTitle ('Собиратель сокровищ');
            cardData.setDescription ('Предсмертный хрип. Вы берете карту');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 39, 0, 0);

            // Чокнутый подрывник (3,2)
			// Боевой клич. Наносит три единицы урона случайному персонажу.
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.RANDOM_ALL);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            eptitude2 = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude2.setLevel (EptitudeLevel.RANDOM_ALL);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2.setPower(1)
            eptitude3 = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude3.setLevel (EptitudeLevel.RANDOM_ALL);
            eptitude3.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude3.setPower(1)
            cardData = new CardData (3, 2, 2, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Чокнутый подрывник');
            cardData.setDescription ('Боевой клич. Наносит три единицы урона случайному персонажу');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 40, 0, 0);

            // Яростный пиромант (3,2)
			// После того как вы разыграли карту заклинания, наносит одну единицу урона всем существам
            eptitude = new CardEptitude (CardEptitude.MASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.EXTRA_ALL_UNITS);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_SPELL);
            eptitude.setPower (1);
            cardData = new CardData (3, 2, 2, [eptitude]);
            cardData.setTitle ('Яростный пиромант');
            cardData.setDescription ('После того как вы разыграли карту заклинания, наносит одну единицу урона всем существам');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 41, 0, 0);
			
			// Ящер кровавой топи (зверь) (3,2)
            cardData = new CardData (3, 2, 2, null);
            cardData.setTitle ('Ящер кровавой топи');
            cardData.setRace(1);
            cardData.setDescription('')
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 42, 0, 0);

            // #3
            // Авантюрист (2,2)
            // Каждый раз когда вы разыгрываете карту это существо получает +1/+1
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_AND_HEALTH);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_PLAY_CARD);
            cardData = new CardData (2, 2, 3, [eptitude]);
            cardData.setTitle ('Авантюрист');
            cardData.setDescription ('Каждый раз когда вы разыгрываете карту это существо получает +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 43, 0, 0);

            // Алый крестоносец (3,1)
            // Божественный щит
            eptitude = new CardEptitude (CardEptitude.SHIELD);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 1, 3, [eptitude]);
            cardData.setTitle ('Алый крестоносец');
            cardData.setDescription ('Божественный щит');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 44, 0, 0);

            // Вайширский оракул (2,2)(мурлок)
            // Боевой клич. Каждый игрок берет по две карты
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ALL)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(2)
            cardData = new CardData (2, 2, 3, [eptitude]);
            cardData.setTitle ('Вайширский оракул');
            cardData.setDescription ('Боевой клич. Каждый игрок берет по две карты');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            CardsCache.getInstance().addCard (cardData, 45, 2, 0);

            // Вайширский провидец (2,3)(мурлок)
            // Боевой клич: все прочие мурлоки получают +2 к здоровью
            eptitude = new CardEptitude (CardEptitude.INCREASE_HEALTH);
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setRace(2)
            eptitude.setPower(2)
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Вайширский провидец');
            cardData.setDescription ('Боевой клич: все прочие мурлоки получают +2 к здоровью');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            CardsCache.getInstance().addCard (cardData, 46, 2, 0);

            // Владычица бесов (1,5)
            // В конце хода получает одну единицу урона и призывает беса +1/+1
            eptitude2 = new CardEptitude(CardEptitude.MASSIVE_ATTACK)
            eptitude2.setLevel(EptitudeLevel.SELF);
            eptitude2.setPeriod(EptitudePeriod.END_STEP)
            eptitude2.setPower(1);
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.END_STEP);
            eptitude.setUnitId(48)
            cardData = new CardData (1, 5, 3, [eptitude, eptitude2]);
            cardData.setTitle ('Владычица бесов');
            cardData.setDescription ('В конце хода получает одну единицу урона и призывает беса +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 47, 0, 0);

            cardData = new CardData (1, 1, 0);
            cardData.setTitle ('Бес');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 48, 0, 0);

            // Всадник на волке (1,3)
            // рывок
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 1, 3, [eptitude]);
            cardData.setTitle ('Всадник на волке');
            cardData.setDescription ('Рывок');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 49, 0, 0);

            // Гризли сталемех (3,3)
            // Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 3, 3, [eptitude]);
            cardData.setTitle ('Гризли сталемех');
            cardData.setDescription ('Првокация');
            cardData.setType(CardData.UNIT)
            cardData.setRace(1)
            CardsCache.getInstance().addCard (cardData, 50, 1, 0);

            // Императорская кобра (2,3)
            // Уничтожает любое существо, которому наносит урон
            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.LAST_ATTACKED_UNIT);
            eptitude.setPeriod (EptitudePeriod.ATTACK);
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Императорская кобра');
            cardData.setDescription ('Првокация');
            cardData.setType(CardData.UNIT)
            cardData.setRace(1)
            CardsCache.getInstance().addCard (cardData, 51, 1, 0);

            // Лидер рейда (2,2)
            // Другие ваши существа получают +1 к аттаке
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (1);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_ASSOCIATE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (1);
            cardData = new CardData (2, 2, 3, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Лидер рейда');
            cardData.setDescription ('Другие ваши существа получают +1 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 52, 0, 0);

            // Маг Даларана
            // Урон от заклинаний +1
            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPower(1);
            cardData = new CardData (1, 4, 3, [eptitude]);
            cardData.setTitle ('Маг Даларана');
            cardData.setDescription ('Урон от заклинаний +1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 53, 0, 0);

            // Магмовый яростень (5,1)
            cardData = new CardData (5, 1, 3);
            cardData.setTitle ('Магнотный яростень');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 54, 0, 0);

            // Ментальный техник (3,3)
            // Если у вашего противника 4 или более существ, вы получаете контроль на случайным существом противника
            eptitude = new CardEptitude (CardEptitude.ENTICE_UNIT);
            eptitude.setLevel(EptitudeLevel.RANDOM_OPPONENT_UNIT);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setCondition(EptitudeCondition.OPPONENT_UNITS_COUNT_MORE_THAN)
            eptitude.setConditionValue(3);
            cardData = new CardData (3, 3, 3, [eptitude]);
            cardData.setTitle ('Ментальный техник');
            cardData.setDescription ('Если у вашего противника 4 или более существ, вы получаете контроль на случайным существом противника');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 55, 2, 0);

            // Мурлок полководец (3,3)
            // Все прочие мурлоки получают +2, +1
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (2);
            eptitude.setRace(2);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (2);
            eptitude2.setRace(2);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (2);
            eptitude3.setRace(2);
            eptitude4 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude4.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude4.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude4.setPower (1);
            eptitude4.setRace(2);
            eptitude5 = new CardEptitude (CardEptitude.DECREASE_HEALTH_BOB);
            eptitude5.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude5.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude5.setPower (1);
            eptitude5.setRace(2);
            eptitude6 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude6.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude6.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude6.setPower (1);
            eptitude6.setRace(2);
            cardData = new CardData (3, 3, 3, [eptitude, eptitude2, eptitude3, eptitude4, eptitude5, eptitude6]);
            cardData.setTitle ('Мурлок полководец');
            cardData.setDescription ('Все прочие мурлоки получают +2, +1');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 56, 2, 0);


            // Опытный охотник (4,2)
            // Боевой клич. Уничтожает существо с атакой 7 или более
            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.SELECTED_OPPONENT_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setCondition(EptitudeCondition.ATTACK_MORE_THAN)
            eptitude.setConditionValue(6)
            cardData = new CardData (4, 2, 3, [eptitude]);
            cardData.setTitle ('Опытный охотник');
            cardData.setDescription ('Боевой клич. Уничтожает существо с атакой 7 или более');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 57, 0, 0);

            // Охотница на иглошкурых
            // Призывает на поле боя вепря +1/+1
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setUnitId(59)
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Охотница на иглошкурых');
            cardData.setDescription ('Призывает на поле боя вепря +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 58, 0, 0);

            cardData = new CardData (1, 1, 0);
            cardData.setTitle ('Вепрь');
            cardData.setDescription ('');
            cardData.setRace(1)
            cardData.setType(CardData.UNIT)
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 59, 0, 0);

            // Плотоядный вурдолак
            // Каждый раз когда умирает существо, плотоядный вурдалак получает +1 к аттаке
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setPeriod (EptitudePeriod.ALL_DIE);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPower(1);
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Плотоядный вурдолак');
            cardData.setDescription ('Каждый раз когда умирает существо, плотоядный вурдалак получает +1 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 60, 0, 0);

            // Провидец Траллмана
            // Неистовство ветра
            eptitude = new CardEptitude (CardEptitude.DOUBLE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Провидец Траллмана');
            cardData.setDescription ('Неистовство ветра');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 61, 0, 0);

            // Разрушитель
            // В начале хода наносит 2 ед. урона случайному персонажу противника.
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.RANDOM_OPPONENT);
            eptitude.setPeriod (EptitudePeriod.START_STEP);
            eptitude.setPower(2)
            cardData = new CardData (1, 4, 3, [eptitude]);
            cardData.setTitle ('Разрушитель');
            cardData.setDescription ('В начале хода наносит 2 ед. урона случайному персонажу противника.');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 62, 0, 0);

            // Разъяренный ворген (3,3)
            // Иступление. При ранении: Неистовство ветра и +1 к аттаке
            eptitude = new CardEptitude (CardEptitude.DOUBLE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_WOUND);
            eptitude2 = new CardEptitude (CardEptitude.CHANGE_ATTACK_TILL);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_WOUND);
            eptitude2.setPower(4)
            cardData = new CardData (3, 3, 3, [eptitude, eptitude2]);
            cardData.setTitle ('Разъяренный ворген');
            cardData.setDescription ('Иступление. При ранении: Неистовство ветра и +1 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 63, 0, 0);

            // Раненый рубака (4,7)
            // Боевой клич. Наносит 4 ед. урона самому себе
            eptitude = new CardEptitude (CardEptitude.MASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(4)
            cardData = new CardData (4, 7, 3, [eptitude]);
            cardData.setTitle ('Раненый рубака');
            cardData.setDescription ('Боевой клич. Наносит 4 ед. урона самому себе');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 64, 0, 0);

            // Ружейник Стальгорна (2,2)
            // Боевой клич: наносит одну единицу урона
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELECTED_OPPONENT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            cardData = new CardData (2, 2, 3, [eptitude]);
            cardData.setTitle ('Ружейник Стальгорна');
            cardData.setDescription ('Боевой клич: наносит одну единицу урона');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 65, 0, 0);

            // Священик синдорай (3,2)
            // Боевой клич. Ваше выбанное существо получает +1/+1
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_AND_HEALTH);
            eptitude.setLevel (EptitudeLevel.SELECTED_ASSOCIATE_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            cardData = new CardData (3, 2, 3, [eptitude]);
            cardData.setTitle ('Священик синдорай');
            cardData.setDescription ( 'Боевой клич. Ваше выбанное существо получает +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 66, 0, 0);

            // Седоспин-патриарх (1,4)
            //Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (1, 4, 3, [eptitude]);
            cardData.setTitle ('Седоспин-патриарх');
            cardData.setDescription ('Првокация');
            cardData.setType(CardData.UNIT)
            cardData.setRace(1)
            CardsCache.getInstance().addCard (cardData, 67, 1, 0);

            // Служитель боли (1,3)
            // Каждый раз когда это существо получает урон, вы берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_WOUND);
            cardData = new CardData (1, 3, 3, [eptitude]);
            cardData.setTitle ('Служитель боли');
            cardData.setDescription ('Каждый раз когда это существо получает урон, вы берете карту');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 68, 0, 0);

            // Служитель земли (3,3)
            // Восстанавливает три единицы урона
            eptitude = new CardEptitude (CardEptitude.TREATMENT);
            eptitude.setLevel (EptitudeLevel.SELECTED_ANY);
            eptitude.setPower(3)
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 3, 3, [eptitude]);
            cardData.setTitle ('Служитель земли');
            cardData.setDescription ('Восстанавливает три единицы урона');
            CardsCache.getInstance().addCard (cardData, 69, 0, 0);

            // Таурен воин (2,3)
            // Провокация. Иступление получает +3 к аттаке
            eptitude = new CardEptitude (CardEptitude.CHANGE_ATTACK_TILL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPower(5);
            eptitude.setPeriod (EptitudePeriod.SELF_WOUND);
            eptitude2 = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 3, 3, [eptitude, eptitude2]);
            cardData.setTitle ('Таурен воин');
            cardData.setDescription ('Провокация. Иступление получает +3 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 70, 1, 0);

            // TODO замена карты
            // Тревогобот
            // В начале хода это существо меняется местами со случайным существом из вашей руки

            // Трапическая пантера
            // Маскировка
            eptitude = new CardEptitude (CardEptitude.SHADOW);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 2, 3, [eptitude]);
            cardData.setTitle ('Тропическая пантера');
            cardData.setDescription ('Маскировка');
            CardsCache.getInstance().addCard (cardData, 71, 0, 0);

            // Уборочный голем
            // Предсмертный хрип: призывает на поле боя поврежденного голема 2/1
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude.setPower(1)
            eptitude.setUnitId(74)
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Уборочный голем');
            cardData.setDescription ('Предсмертный хрип: призывает на поле боя поврежденного голема 2/1');
            CardsCache.getInstance().addCard (cardData, 73, 0, 0);

            cardData = new CardData (2, 1, 0);
            cardData.setTitle ('Поврежденный голем');
            cardData.setDescription ('');
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 74, 0, 0);

            // #4 маны

            // Глава культа (4,2)
            // Когда другое ваше существо умирает вы берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_DIE);
            eptitude.setPower(1)
            cardData = new CardData (4, 2, 4, [eptitude]);
            cardData.setTitle ('Глава культа');
            cardData.setDescription ('Когда другое ваше существо умирает вы берете карту');
            CardsCache.getInstance().addCard (cardData, 80, 0, 0);

            // Гном изобретатель 4 2
            // Боевой клич: вы берете карту
            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            cardData = new CardData (2, 4, 4, [eptitude]);
            cardData.setTitle ('Гном призыватель');
            cardData.setDescription (' Боевой клич: вы берете карту');
            CardsCache.getInstance().addCard (cardData, 81, 0, 0);


            // Дворф черного железа 4 4
            // Боевой клич. Выбранное существо получает +2 к аттаке до конца хода
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELECTED_ASSOCIATE_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (2);
            eptitude.setLifecycle(1);
            cardData = new CardData (4, 4, 4, [eptitude]);
            cardData.setTitle ('Дворф черного железа');
            cardData.setDescription ('Боевой клич. Выбранное существо получает +2 к аттаке до конца хода');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 82, 0, 0);

            // Дракономеханик 4 2
            // Боевой клич. Призывает на поле боля механодракончика +2/+1
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            eptitude.setUnitId(84)
            cardData = new CardData (4, 2, 4, [eptitude]);
            cardData.setTitle ('Дракономеханик');
            cardData.setDescription ('Боевой клич. Призывает на поле боля механодракончика +2/+1');
            CardsCache.getInstance().addCard (cardData, 83, 0, 0);

            cardData = new CardData (2, 1, 0);
            cardData.setTitle ('Механодракончик');
            cardData.setDescription ('');
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 84, 0, 0);

            // Древний маг 2 5
            // Боевой клич. Находящиеся по обе стороны существа получают способность "Урон от заклинаний +1"
            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            cardData = new CardData (2, 5, 4, [eptitude]);
            cardData.setTitle ('Древний маг');
            cardData.setDescription ('Боевой клич. Находящиеся по обе стороны существа получают способность "Урон от заклинаний +1"');
            CardsCache.getInstance().addCard (cardData, 85, 0, 0);

            // Защитник аргуса 2 3
            // Боевой клич. Существа по обе стороны получают +1/+1 и способность провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2 = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude2.setPower(1)
            eptitude2.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_HEALTH);
            eptitude3.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude3.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude3.setPower(1)
            cardData = new CardData (2, 3, 4, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Защитник аргуса');
            cardData.setDescription ('Боевой клич. Существа по обе стороны получают +1/+1 и способность провокация');
            CardsCache.getInstance().addCard (cardData, 86, 0, 0);

            // Морозный йетти 4 5
            cardData = new CardData (4, 5, 4);
            cardData.setTitle ('Морозный Йетти');
            cardData.setDescription ('');
            CardsCache.getInstance().addCard (cardData, 87, 0, 0);

            // Оазисный хрустогрыз 2 7
            cardData = new CardData (2, 7, 4);
            cardData.setTitle ('Оазисный хрустогрыз');
            cardData.setDescription ('');
            CardsCache.getInstance().addCard (cardData, 88, 0, 0);

            // Рыцарь штормграда 2 5
            // Рывок
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (2, 5, 4, [eptitude]);
            cardData.setTitle ('Рыцарь Штормграда');
            cardData.setDescription ('Рывок');
            CardsCache.getInstance().addCard (cardData, 89, 0, 0);


            // Старый мрачноглаз 2 4
            // Рывок, получает + 1 за каждого другого мурлока на поле боя
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2 = new CardEptitude (CardEptitude.INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2.setAttachment(EptitudeAttachment.ALL)
            eptitude2.setRace(2);
            cardData = new CardData (2, 4, 4, [eptitude, eptitude2]);
            cardData.setTitle ('Старый мрачноглаз');
            cardData.setDescription ('Рывок, получает + 1 за каждого другого мурлока на поле боя');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 90, 0, 0);


            // Старый хмелевар 5 4
            // Возвращает ваше выбранное существо с поле боя в вашу руку
            eptitude = new CardEptitude (CardEptitude.BACK_CARD_TO_HAND);
            eptitude.setLevel (EptitudeLevel.SELECTED_ASSOCIATE_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (5, 4, 4, [eptitude]);
            cardData.setTitle ('Старый хмелевар');
            cardData.setDescription ('Возвращает ваше выбранное существо с поле боя в вашу руку');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 91, 0, 0);

            // Страж луносвета 3 3
            // Божественный щит
            eptitude = new CardEptitude (CardEptitude.SHIELD);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 3, 4, [eptitude]);
            cardData.setTitle ('Страж луносвета');
            cardData.setDescription ('Божественный щит');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 92, 0, 0);

            // Стражник Могу'шан 1 7
            // Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (1, 7, 4, [eptitude]);
            cardData.setTitle ("Стражник Могу'шан");
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 93, 0, 0);

            // Сумеречный дракон 4 1
            // Боевой клич. Это существо получает +1 к здоровью за каждую карту в вашей руке
            eptitude = new CardEptitude(CardEptitude.INCREASE_HEALTH_DEPENDS_ON_CARDS);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setLevel(EptitudeLevel.SELF)
            cardData = new CardData (4, 1, 4, [eptitude]);
            cardData.setTitle ('Сумеречный дракон');
            cardData.setDescription ('Боевой клич. Это существо получает +1 к здоровью за каждую карту в вашей руке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 94, 0, 0);

            // Учительница магии 3 5
            // Каждый раз когда вы разыгрываете карту призывает на поле мага ученика +1/+1
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_SPELL);
            eptitude.setPower(1)
            eptitude.setUnitId(94)
            cardData = new CardData (3, 5, 4, [eptitude]);
            cardData.setTitle ("Учительница магии");
            cardData.setDescription ('Каждый раз когда вы разыгрываете карту призывает на поле мага ученика +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 95, 0, 0);

            cardData = new CardData (1, 1, 0);
            cardData.setTitle ('Маг ученик');
            cardData.setDescription ('');
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 96, 0, 0);

            // Щитоносец Сен'джин 4 5
            // Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 5, 4, [eptitude]);
            cardData.setTitle ("Щитоносец Сен'джин");
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 97, 0, 0);

            // #5 маны

            // Алчный наемник 7 6
            // Ваши существа стоят на три маны больше
            eptitude = new CardEptitude (CardEptitude.CARD_SALE);
            cardSale = new CardSale(CardSale.UNIT_CARD, false, 10, -3);
            eptitude.setSale(cardSale)
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel(EptitudeLevel.SELF)
            eptitude.setPeriod(EptitudePeriod.START_STEP)
            eptitude2 = new CardEptitude (CardEptitude.CARD_SALE);
            cardSale = new CardSale(CardSale.UNIT_CARD, false, 10, 3);
            eptitude2.setSale(cardSale)
            eptitude2.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude2.setLevel(EptitudeLevel.SELF)
            eptitude2.setPeriod(EptitudePeriod.SELF_DIE)
            cardData = new CardData (7, 6, 5, [eptitude, eptitude2]);
            cardData.setTitle ('Алчный наемник');
            cardData.setDescription ('Ваши существа стоят на три маны больше');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 98, 0, 0);

            // Безликий манипулятор 3 3
            // Боевой клич. Становится копией выбранного существа
            eptitude = new CardEptitude(CardEptitude.COPY_UNIT);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setLevel(EptitudeLevel.SELECTED_ANY_UNIT)
            cardData = new CardData (3, 3, 5, [eptitude]);
            cardData.setTitle ('Безликий манипулятор');
            cardData.setDescription ('Боевой клич. Становится копией выбранного существа');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 99, 0, 0);

            // Берсек Гурубаши 2 7
            // Когда этому существу наносится урон, оно прибавляет +3 к аттаке
            eptitude = new CardEptitude(CardEptitude.INCREASE_ATTACK);
            eptitude.setPower(3)
            eptitude.setPeriod(EptitudePeriod.SELF_WOUND)
            eptitude.setLevel(EptitudeLevel.SELF)
            cardData = new CardData (2, 7, 5, [eptitude]);
            cardData.setTitle ('Берсек Гурубаши');
            cardData.setDescription ('Когда этому существу наносится урон, оно прибавляет +3 к аттаке');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 100, 0, 0);

            // Вождь северного волка 4 4
            // Боевой клич. Получает +1 +1 за кажде другое существо на поле боя
            eptitude = new CardEptitude(CardEptitude.INCREASE_HEALTH_DEPENDS_ON_TOKENS);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setLevel(EptitudeLevel.SELF)
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude2 = new CardEptitude(CardEptitude.INCREASE_ATTACK_DEPENDS_ON_TOKENS);
            eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude2.setLevel(EptitudeLevel.SELF)
            eptitude2.setAttachment(EptitudeAttachment.ASSOCIATE)
            cardData = new CardData (4, 4, 5, [eptitude, eptitude2]);
            cardData.setTitle ('Вождь северного волка');
            cardData.setDescription ('Боевой клич. Получает +1 +1 за кажде другое существо на поле боя');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 101, 0, 0);

            // Гоблин аукционист 4 4
            // Каждый раз когда вы разыгрываете заклинание вы берете карту
            eptitude = new CardEptitude(CardEptitude.PICK_CARD);
            eptitude.setPower(1)
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPeriod(EptitudePeriod.ASSOCIATE_SPELL)
            eptitude.setLevel(EptitudeLevel.SELF)
            cardData = new CardData (4, 4, 5, [eptitude]);
            cardData.setTitle ('Гоблин аукционист');
            cardData.setDescription ('Каждый раз когда вы разыгрываете заклинание вы берете карту');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 102, 0, 0);

            // Гоблин телохранитель 5 4
            // Провокация
            eptitude = new CardEptitude(CardEptitude.PROVOCATION);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setLevel(EptitudeLevel.SELF)
            cardData = new CardData (5, 4, 5, [eptitude]);
            cardData.setTitle ('Гоблин телохранитель');
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 103, 0, 0);

            // Дворф диверсант 4 2
            // Боевой клич. Наносит две единицы урона
            eptitude = new CardEptitude(CardEptitude.PASSIVE_ATTACK);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT)
            eptitude.setPower(2)
            cardData = new CardData (4, 2, 5, [eptitude]);
            cardData.setTitle ('Дворф диверсант');
            cardData.setDescription ('Боевой клич. Наносит две единицы урона');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 104, 0, 0);

            // Лазурный дракон 4 4
            // Урон от заклинаний +1. Боевой клич. вы берете карту
            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPower(1);
            eptitude2 = new CardEptitude(CardEptitude.PICK_CARD)
            eptitude2.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude2.setPower(1)
            eptitude2.setLevel(EptitudeLevel.SELF)
            eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
            cardData = new CardData (4, 4, 5, [eptitude, eptitude2]);
            cardData.setTitle ('Лазурный дракон');
            cardData.setDescription ('Урон от заклинаний +1. Боевой клич. вы берете карту');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 105, 0, 0);

            // Нага целительница 4 5
            // Боевой клич. Восстанавливает 2 единицы урона всем вашим персонажам.
            eptitude = new CardEptitude (CardEptitude.TREATMENT);
            eptitude.setPower(2)
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 5, 5, [eptitude]);
            cardData.setTitle ('Нага целительница');
            cardData.setDescription ('Боевой клич. Восстанавливает 2 единицы урона всем вашим персонажам');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 106, 0, 0);

            // Несущийся кодо 3 5
            // Боевой клич. Уничтожает случайное существо противника с аттакой 2 или меньше
            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.RANDOM_OPPONENT_UNIT);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setCondition(EptitudeCondition.ATTACK_LESS_THAN)
            eptitude.setConditionValue(3)
            cardData = new CardData (3, 5, 5, [eptitude]);
            cardData.setTitle ('Несущийся кодо');
            cardData.setDescription ('Боевой клич. Уничтожает случайное существо противника с аттакой 2 или меньше');
            CardsCache.getInstance().addCard (cardData, 107, 0, 0);

            // Ночной клинок 4 4
            // Боевой клич. Наносит 3 единицы урона герою противника
            eptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
            eptitude.setPower(3)
            eptitude.setLevel (EptitudeLevel.OPPONENT_HERO);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 4, 5, [eptitude]);
            cardData.setTitle ('Ночной клинок');
            cardData.setDescription ('Боевой клич. Наносит 3 единицы урона герою противника');
            CardsCache.getInstance().addCard (cardData, 108, 0, 0);

            eptitude = new CardEptitude (CardEptitude.MASSIVE_ATTACK);
            eptitude.setPower(2)
            eptitude.setLevel (EptitudeLevel.ALL);
            eptitude.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2 = new CardEptitude(CardEptitude.PROVOCATION)
            eptitude2.setLevel(EptitudeLevel.SELF)
            eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
            cardData = new CardData (4, 4, 5, [eptitude, eptitude2]);
            cardData.setTitle ('Поганище');
            cardData.setDescription ('Провокация Предсмертный хрип. Наносит 2 единицы урона всем существам');
            CardsCache.getInstance().addCard (cardData, 109, 0, 0);

            // Призрачный рыцарь. 4 6
            // Не может быть целью заклинаний и силы героя
            eptitude = new CardEptitude (CardEptitude.SPELL_INVISIBLE);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 6, 5, [eptitude]);
            cardData.setTitle ('Призрачный рыцарь');
            cardData.setDescription ('Не может быть целью заклинаний и силы героя');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 110, 0, 0);

            // Рыцарь длани 4 4
            // Боевой клич. Призывает на поле боя оруженосца 2 2
            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            eptitude.setUnitId(112)
            cardData = new CardData (4, 4, 5, [eptitude]);
            cardData.setTitle ('Рыцарь длани');
            cardData.setDescription (' Боевой клич. Призывает на поле боя оруженосца 2 2 +2/+1');
            CardsCache.getInstance().addCard (cardData, 111, 0, 0);

            cardData = new CardData (2, 2, 0);
            cardData.setTitle ('Оруженосец');
            cardData.setDescription ('');
            cardData.auxiliary = true;
            CardsCache.getInstance().addCard (cardData, 112, 0, 0);

            // Тигр горнистой долины 5 5
            // Маскировка
            eptitude = new CardEptitude (CardEptitude.SHADOW);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (5, 5, 5, [eptitude]);
            cardData.setTitle ('Тигр горнистой долины');
            cardData.setDescription ('Маскировка');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 113, 0, 0);


            // Трясинный ползун 3 6
            // Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (3, 6, 5, [eptitude]);
            cardData.setTitle ('Трясинный ползун');
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 114, 0, 0);

            // #6

            // Верховный маг 4 7
            // Урон от заклинаний +1
            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPower(1);
            cardData = new CardData (4, 7, 6, [eptitude]);
            cardData.setTitle ('Верховный маг');
            cardData.setDescription ('Урон от заклинаний +1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 120, 0, 0);

            // Жрица элуны 5 4
            // Восстанавливает 4 ед. героя вашему герою
            eptitude = new CardEptitude (CardEptitude.TREATMENT);
            eptitude.setLevel (EptitudeLevel.ASSOCIATE_HERO);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(4);
            cardData = new CardData (5, 4, 6, [eptitude]);
            cardData.setTitle ('Жрица элуны');
            cardData.setDescription ('Восстанавливает 4 ед. героя вашему герою');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 121, 0, 0);

            // Командир Авангарда 4 2
            // Божественный жит. Рывок
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2 = new CardEptitude (CardEptitude.SHIELD);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 2, 6, [eptitude, eptitude2]);
            cardData.setTitle ('Командир Авангарда');
            cardData.setDescription ('Божественный жит. Рывок');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 122, 0, 0);

            // Ледяной элементаль 5 5
            // Боевой клич. Замораживает выбранного персонажа
            eptitude = new CardEptitude (CardEptitude.FREEZE);
            eptitude.setLevel (EptitudeLevel.SELECTED_ANY);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(0)
            cardData = new CardData (5, 5, 6, [eptitude]);
            cardData.setTitle ('Ледяной элементаль');
            cardData.setDescription ('Боевой клич. Замораживает выбранного персонажа');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 123, 0, 0);

            // Неистовая гарпия 4 5
            // Неистовство ветра
            eptitude = new CardEptitude (CardEptitude.DOUBLE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 5, 6, [eptitude]);
            cardData.setTitle ('Неистовая гарпия');
            cardData.setDescription ('Неистовство ветра');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 124, 0, 0);

            // Огр тяжелого кулака 6 7
            cardData = new CardData (6, 7, 6, null);
            cardData.setTitle ('Огр тяжелого кулака');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 125, 0, 0);

            // Повелитель арены 6 5
            // Провокация
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (6, 5, 6, [eptitude]);
            cardData.setTitle ('Повелитель арены');
            cardData.setDescription ('Провокация');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 126, 0, 0);

            // Служительница солнца 4 5
            // Провокация. Божественный щит
            eptitude = new CardEptitude (CardEptitude.PROVOCATION);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2 = new CardEptitude (CardEptitude.SHIELD);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (4, 5, 6, [eptitude, eptitude2]);
            cardData.setTitle ('Служительница солнца');
            cardData.setDescription ('Провокация. Божественный щит');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 127, 0, 0);

            // Шальная ракетчица 5 2
            // рывок
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            cardData = new CardData (5, 2, 6, [eptitude]);
            cardData.setTitle ('Шальная ракетчица');
            cardData.setDescription ('Рывок');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 128, 0, 0);

            // Боевой голем 7 7
            cardData = new CardData (7, 7, 6);
            cardData.setTitle ('Боевой голем');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 129, 0, 0);

            // Герой штормграда
            // Другие ваши существа получают +1/+1
            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (1);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_ASSOCIATE);
            eptitude3.setPeriod (EptitudePeriod.ASSOCIATE_PLACED);
            eptitude3.setPower (1);
            eptitude4 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude4.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude4.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude4.setPower (1);
            eptitude5 = new CardEptitude (CardEptitude.DECREASE_HEALTH_BOB);
            eptitude5.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude5.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude5.setPower (1);
            eptitude6 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude6.setLevel (EptitudeLevel.LAST_PLACED_ASSOCIATE);
            eptitude6.setPeriod (EptitudePeriod.ASSOCIATE_PLACED);
            eptitude6.setPower (1);
            cardData = new CardData (6, 6, 6, [eptitude, eptitude2, eptitude3, eptitude4, eptitude5, eptitude6]);
            cardData.setTitle ('Герой Штормграда');
            cardData.setDescription ('Другие ваши существа получают +1/+1');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 130, 0, 0);

            // Гончая недр 9 5
            cardData = new CardData (9, 5, 6);
            cardData.setTitle ('Гончая недр');
            cardData.setDescription ('');
            cardData.setType(CardData.UNIT)
            CardsCache.getInstance().addCard (cardData, 131, 0, 0);

            //
            //

            //
            //

            //
            //

            //
            //

            //
            //

            //
            //

            //
            //

            //
            //
        }
		
	}

}
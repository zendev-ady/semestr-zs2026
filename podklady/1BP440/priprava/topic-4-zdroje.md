# Téma 4 — Kryptoměny, blockchain a smart kontrakty

Zpracováno **30. 9. 2026**. Výstup `topic-4.html` je externí studijní výklad podle sylabu, nikoli zápis přednášky. Společné zadání, sylabus, plán, metadata, existující stránka a CSS přečteny při předchozím tématu a aplikovány i zde.

## Pokrytí

Sylabové kryptoměny, blockchain a smart kontrakty vysvětleny prostřednictvím DLT, hashování a podpisů, klíčů/wallet/custody, transakčního cyklu a dvojího utracení, UTXO versus účty, PoW a PoS, Bitcoin versus Ethereum, EVM, gas, tokenů/ERC-20/NFT, stablecoinů, oracles a základů škálování. Čtyři modelové příklady: konkurenční utracení, bitcoinový výstup a vrácení zbytku, výpočet gas poplatku, pojištění sucha. DeFi produkty a regulatorní detaily odkázány do témat 5–6. Praktický pohled klienta i manažera je rozveden u custody, automatizace a externích dat.

## Otevřené zdroje

1. **Petr Teplý, VŠE / Institut udržitelných financí: Jsou kryptoaktiva udržitelná investice pro banky?**, 28. 3. 2023. [PDF](https://iuf.vse.cz/wp-content/uploads/page/25/Udrzitelnost-krypto-P.Teply-VSE-230328-final.pdf), s. 3 terminologie, s. 9 historické pojetí konsenzu. Odborná prezentace vyučujícího, ale jiné akce; není prezentací 1BP440. Ethereum uvedené mezi PoW příklady výslovně korigováno. Nepoužita energetická čísla za 2022 ani normativní investiční závěry.
2. **Gary Gensler, MIT OCW, Blockchain and Money**, podzim 2018, Session 3: Blockchain Basics & Cryptography. [Otevřený PDF](https://ocw.mit.edu/courses/15-s12-blockchain-and-money-fall-2018/2bb211550888131c1c80ca68abac4131_MIT15_S12F18_ses3.pdf). Výukový materiál k hashování, digitálním podpisům a základům blockchainu.
3. **Gary Gensler, MIT OCW**, 2018, Session 4: Blockchain Basics and Consensus. [PDF](https://ocw.mit.edu/courses/15-s12-blockchain-and-money-fall-2018/3bcae7f65945633fc0ae6b955f36dfb4_MIT15_S12F18_ses4.pdf). Distribuovaný konsenzus, Sybilův problém, otevřené a povolené sítě. Historická ethereum implementace nepřebírána.
4. **Gary Gensler, MIT OCW**, 2018, Session 5: Blockchain Basics and Transactions, UTXO, and Script Code. [PDF](https://ocw.mit.edu/courses/15-s12-blockchain-and-money-fall-2018/51c129201af1dc294b6488b670cac3ce_MIT15_S12F18_ses5.pdf). Bitcoinové výstupy, transakce a skriptové podmínky. Všechny tři konkrétní PDF skutečně otevřeny přes stránku zdrojů kurzu, nejde pouze o katalog kurzu.
5. **Satoshi Nakamoto: Bitcoin: A Peer-to-Peer Electronic Cash System**, 2008. [Whitepaper](https://bitcoin.org/bitcoin.pdf), § 3–6 (řetězení, PoW, síť), § 9 (kombinování a dělení hodnoty), § 10 (soukromí). Primární návrh systému; není používán jako kompletní aktuální specifikace všech bitcoinových funkcí.
6. **ethereum.org, komunitní technická dokumentace Ethereum**, živé stránky, datum přístupu 30. 9. 2026. Všechny níže uvedené stránky otevřeny. Citovány podle konkrétního mechanismu, nikoli jako právní nebo nezávislý investiční zdroj:
   - [Technical introduction](https://ethereum.org/en/developers/docs/intro-to-ethereum/): ETH a EVM.
   - [Accounts](https://ethereum.org/en/developers/docs/accounts/): klíče, adresy, zůstatky a nonce.
   - [Wallets](https://ethereum.org/en/wallets/): peněženka jako rozhraní, účty/klíče/adresy.
   - [Transactions](https://ethereum.org/en/developers/docs/transactions/): zpracování a změny stavu.
   - [Proof-of-stake](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/): validace, finalita a slashing.
   - [The Merge](https://ethereum.org/en/roadmap/merge/): primární potvrzení přechodu na PoS **15. 9. 2022**. Nepoužíváme označení „Ethereum 2.0“ jako novou dnešní měnu nebo samostatnou síť.
   - [Introduction to smart contracts](https://ethereum.org/en/developers/docs/smart-contracts/): programy, stav, vyvolání a omezení.
   - [Gas and fees](https://ethereum.org/en/developers/docs/gas/): gas versus cena, jednotky gwei, base/priority fee, úhrada provedeného výpočtu i při selhání.
   - [ERC-20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) a [ERC-721](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/): rozhraní zaměnitelných a nezaměnitelných tokenů.
   - [Stablecoins](https://ethereum.org/en/stablecoins/): typy stabilizačních mechanismů; marketingově kategorické výroky o bezpečnosti nepřebírány jako záruka.
   - [Oracles](https://ethereum.org/en/developers/docs/oracles/): externí data a deterministické vykonání.
   - [Scaling](https://ethereum.org/en/developers/docs/scaling/): layer 2, rollupy a rozdíl oproti sidechainu. Výklad vynechává aktuální počty transakcí a konkrétní provozní parametry projektů.

## Nejistoty a kontrola

- Původní slidy 1BP440 nejsou dostupné. Přiřazení k tématu je podle plánu a zadání; neprokazuje obsah konkrétní přednášky ani otázky vyučujícího.
- Doporučené knihy Birrer a kol. / Levis nebyly dostupné v plném textu, a proto nejsou vydávány za prostudované zdroje.
- Tržní kurzy, sazby stakingu, energetické odhady ani současné regulatorní podmínky nejsou tvrzeny. PoS přechod Ethereum je ověřený historický fakt. Živé technické stránky mohou být následně aktualizovány.
- Modelový gas výpočet: 21 000 × 18 gwei = 0,000378 ETH; base 0,000315 a priority 0,000063 ETH. Částky jsou ilustrační; nejsou převzaty jako současné sazby.
- Fragment má jednu sekci `topic-4`, shrnutí, odpovídající quizový odkaz a odkazy na návaznosti. Žádné quizové otázky, sdílené soubory ani metadata nebyly měněny.

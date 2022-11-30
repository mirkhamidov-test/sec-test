<?php

declare(strict_types=1);

namespace App\Repository;

use App\Collection\FlagBitCollection;
use App\Enum\DatasetEnum;
use App\Exception\FlagBitUpdateUnexpectedException;
use App\Exception\TransactionNotFoundException;
use App\Model\FlagBitChangeResult;

class TransactionsRepository extends AbstractNonEntityRepository
{
    private const MODE_CHANGE_ADD = 1;

    private const MODE_DISABLE = 2;

    public function enableFlagBitToTransaction(int $transactionId, int $flagBit, int $userId)
    {
        $sql = <<<EOF
CALL stamd_aendern_erstellen_flagbit_ref(
    :dataSetType,
    :dataSetKey,
    :flagBit,
    :mode,
    :changedBy,
    @out_code,
    @out_text
    );
EOF;
        $stmt = $this->getConnection()->prepare($sql);
        $stmt->executeStatement([
            'dataSetType' => DatasetEnum::TRANS_ID->value,
            'dataSetKey' => $transactionId,
            'flagBit' => $flagBit,
            'mode' => self::MODE_CHANGE_ADD,
            'changedBy' => $userId,
        ]);

        $stmt = $this->getConnection()->prepare('SELECT @out_code "errorCode", @out_text "errorMessage"');

        $resultSet = $stmt->executeQuery();

        $result = $resultSet->fetchAssociative();

        if (!$result) {
            throw new FlagBitUpdateUnexpectedException();
        }

        return new FlagBitChangeResult($result['errorCode'], $result['errorMessage'] ?? '');
    }

    public function findFlagBitsByTransId(int $transId): FlagBitCollection
    {
        $sql = <<<EOF
select
    tt.trans_id,
    md_fr.flagbit
FROM stamd_flagbit_ref md_fr
    RIGHT JOIN transaktion_transaktionen tt on md_fr.datensatz_id = tt.trans_id AND md_fr.datensatz_typ_id= :dataSetType
    INNER JOIN vorgaben_zeitraum vz ON (vz.zeitraum_id = md_fr.zeitraum_id)
WHERE tt.trans_id = :transactionId
AND NOW() BETWEEN vz.von AND vz.bis
EOF;
        $stmt = $this->getConnection()->prepare($sql);
        $resultSet = $stmt->executeQuery([
            'dataSetType' => DatasetEnum::TRANS_ID->value,
            'transactionId' => $transId,
        ]);

        if ($resultSet->rowCount() === 0) {
            throw new TransactionNotFoundException($transId);
        }

        $collection = new FlagBitCollection();

        foreach ($resultSet->iterateAssociative() as $value) {
            if (null === $value['flagbit']) {
                continue;
            }

            $collection->add((string) $value['flagbit']);
        }

        return $collection;
    }
}
